# Containeralized Server of `llama.cpp`
Containerized server for **@ggerganov's** [`llama.cpp`](https://github.com/ggerganov/llama.cpp) library.
`scripts/LlamacppLLM.py` is a langchain integration. 

## Why not binding?
`llama.cpp` developement moves extremely fast and binding projects just don't keep up with the updates.
That means you can’t have the most optimized models.

## Usage
```
docker build -t llamacpp-server .
docker run -p 8200:8200 -v /path/to/models:/models llamacpp-server -m /models/llama-13b.ggmlv3.q2_K.bin
```

Example for downloading a model
```
mkdir models
cd models
wget https://huggingface.co/TheBloke/LLaMa-13B-GGML/resolve/main/llama-13b.ggmlv3.q2_K.bin
```

Note: The above instructions assume you have Docker installed on your machine. Make sure to replace `/path/to/models` with the actual path to the directory where you have downloaded the models.