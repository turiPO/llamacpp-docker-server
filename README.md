# Containeralized Server of llama.cpp
Simple as that.
Replace `/path/to/models` below with the actual path where you downloaded the models.
```
docker build -t llamacpp-server .
docker run -v /path/to/models:/models llamacpp-server -m /models/7B/ggml-model-q4_0.bin
```