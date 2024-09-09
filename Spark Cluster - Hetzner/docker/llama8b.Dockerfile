FROM debian:bookworm-slim AS builder

WORKDIR /llama_app

RUN apt-get update && \
        apt-get install -y --no-install-recommends \
        wget \
        vim \
        ca-certificates && \
        wget https://huggingface.co/Mozilla/Meta-Llama-3.1-8B-Instruct-llamafile/resolve/main/Meta-Llama-3.1-8B-Instruct.Q6_K.llamafile -O llama8b.llamafile && \
        chmod +x llama8b.llamafile && \
        apt-get purge -y --auto-remove wget && \
        apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /usr/share/doc/* /usr/share/man/*

FROM debian:bookworm-slim

WORKDIR /llama_app

COPY --from=builder /llama_app/llama8b.llamafile .

EXPOSE 9090

CMD ["/bin/bash", "./llama8b.llamafile", "--server", "--nobrowser", "--host", "0.0.0.0", "--port", "9090", "--parallel", "2"]