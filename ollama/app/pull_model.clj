(ns pull-model
  (:require [babashka.process :refer [shell]]
            [clojure.core.async :refer [chan timeout >!! <!! go-loop alts!]]))

(defn pull-model []
  (let [llm (System/getenv "LLM")
        url (System/getenv "OLLAMA_BASE_URL")]
    (println (format "Attempting to pull Ollama model %s from %s" llm url))
    (if (and llm url (not (contains? #{"gpt-4" "gpt-3.5" "claudev2"} llm)))
      (do
        (println "Conditions met, starting model pull...")
        (let [done (chan)
              command-str (str "bash -c '/usr/local/bin/ollama show " llm " --modelfile > /dev/null || /usr/local/bin/ollama pull " llm "'")]
          (go-loop [n 0]
            (when-not (= :stop (alts! [done (timeout 5000)]))
              (println (format "... pulling model (%ss) - will take several minutes" (* n 5)))
              (recur (inc n))))
          (shell {:out :inherit :err :inherit :env {"OLLAMA_HOST" url}} command-str)
          (>!! done :stop))
        (println "Model pull operation completed."))
      (println "Model not pulled: either conditions were not met or model is restricted."))))

(defn -main []
  (println "Starting the application...")
  (try
    (pull-model)
    (catch Exception e
      (println "An error occurred:" (.getMessage e))
      (System/exit 1))))
      
;; If you want the script to execute when run directly:
(-main)