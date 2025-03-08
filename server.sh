# Multi LoRA

# OpenELM-1.1B
./llama-server -m /home/zheyu/code/llama.cpp/models/OpenELM-1_1B-GGUF/Q4_0/Q4_0-00001-of-00001.gguf -c 25600 --lora_repeated /home/zheyu/code/llama.cpp/models/aac/lora.gguf 50 --adapter_cache_size 50 --parallel 60 --batch_lora true --n-gpu-layers 999

# Gemma2-2B

# Phi3.5-mini

# Llama3.2-3B
./llama-server -m /home/zheyu/code/llama.cpp/models/Llama-Sentient-3.2-3B-Instruct-GGUF/Llama-Sentient-3.2-3B-Instruct.Q4_0.gguf -c 51200 --lora_repeated /home/zheyu/code/llama.cpp/models/Meta-Llama-3.2-3B-MEDAL-finetune/Meta-Llama-3.2-3B-MEDAL-finetune-F16-LoRA.gguf 50 --adapter_cache_size 50 --parallel 40 --batch_lora true --n-gpu-layers 999

# Llama3.1-8B
./llama-server -m /home/zheyu/code/llama.cpp/models/Meta-Llama-3.1-8B-Instruct-GGUF/Meta-Llama-3.1-8B-Instruct-Q8_0.gguf -c 102400 --lora_repeated /home/zheyu/code/llama.cpp/models/Llama-3_1-8B-Instruct-orca-ORPO/Llama-8B-3_1-Instruct-orca-ORPO-F16-LoRA.gguf 20 --adapter_cache_size 20 --parallel 20 --batch_lora true --n-gpu-layers 999

# llama.cpp
