help:
    @just --list

clean:
    rm -rf build

download version:
    rm -rf build/releases
    wget -P build/releases https://github.com/casey/just/releases/download/{{version}}/just-{{version}}-aarch64-apple-darwin.tar.gz
    wget -P build/releases https://github.com/casey/just/releases/download/{{version}}/just-{{version}}-aarch64-unknown-linux-musl.tar.gz
    wget -P build/releases https://github.com/casey/just/releases/download/{{version}}/just-{{version}}-arm-unknown-linux-musleabihf.tar.gz
    wget -P build/releases https://github.com/casey/just/releases/download/{{version}}/just-{{version}}-armv7-unknown-linux-musleabihf.tar.gz
    wget -P build/releases https://github.com/casey/just/releases/download/{{version}}/just-{{version}}-x86_64-apple-darwin.tar.gz
    wget -P build/releases https://github.com/casey/just/releases/download/{{version}}/just-{{version}}-x86_64-pc-windows-msvc.zip
    wget -P build/releases https://github.com/casey/just/releases/download/{{version}}/just-{{version}}-x86_64-unknown-linux-musl.tar.gz

unzip version:
    rm -rf build/unzipped

    mkdir -p build/unzipped/just-{{version}}-aarch64-apple-darwin
    tar -xvzf build/releases/just-{{version}}-aarch64-apple-darwin.tar.gz -C build/unzipped/just-{{version}}-aarch64-apple-darwin

    mkdir -p build/unzipped/just-{{version}}-aarch64-unknown-linux-musl
    tar -xvzf build/releases/just-{{version}}-aarch64-unknown-linux-musl.tar.gz -C build/unzipped/just-{{version}}-aarch64-unknown-linux-musl

    mkdir -p build/unzipped/just-{{version}}-arm-unknown-linux-musleabihf
    tar -xvzf build/releases/just-{{version}}-arm-unknown-linux-musleabihf.tar.gz -C build/unzipped/just-{{version}}-arm-unknown-linux-musleabihf

    mkdir -p build/unzipped/just-{{version}}-armv7-unknown-linux-musleabihf
    tar -xvzf build/releases/just-{{version}}-armv7-unknown-linux-musleabihf.tar.gz -C build/unzipped/just-{{version}}-armv7-unknown-linux-musleabihf

    mkdir -p build/unzipped/just-{{version}}-x86_64-apple-darwin
    tar -xvzf build/releases/just-{{version}}-x86_64-apple-darwin.tar.gz -C build/unzipped/just-{{version}}-x86_64-apple-darwin

    mkdir -p build/unzipped/just-{{version}}-x86_64-pc-windows-msvc
    tar -xvzf build/releases/just-{{version}}-x86_64-pc-windows-msvc.zip -C build/unzipped/just-{{version}}-x86_64-pc-windows-msvc

    mkdir -p build/unzipped/just-{{version}}-x86_64-unknown-linux-musl
    tar -xvzf build/releases/just-{{version}}-x86_64-unknown-linux-musl.tar.gz -C build/unzipped/just-{{version}}-x86_64-unknown-linux-musl

repackage version:
    rm -rf build/repackaged
    mkdir -p build/repackaged
    cp -r build/unzipped/* build/repackaged

    mkdir -p build/repackaged/just-{{version}}-aarch64-apple-darwin/bin
    mv build/repackaged/just-{{version}}-aarch64-apple-darwin/just* build/repackaged/just-{{version}}-aarch64-apple-darwin/bin  

    mkdir -p build/repackaged/just-{{version}}-aarch64-unknown-linux-musl/bin
    mv build/repackaged/just-{{version}}-aarch64-unknown-linux-musl/just* build/repackaged/just-{{version}}-aarch64-unknown-linux-musl/bin  

    mkdir -p build/repackaged/just-{{version}}-arm-unknown-linux-musleabihf/bin
    mv build/repackaged/just-{{version}}-arm-unknown-linux-musleabihf/just* build/repackaged/just-{{version}}-arm-unknown-linux-musleabihf/bin  

    mkdir -p build/repackaged/just-{{version}}-armv7-unknown-linux-musleabihf/bin
    mv build/repackaged/just-{{version}}-armv7-unknown-linux-musleabihf/just* build/repackaged/just-{{version}}-armv7-unknown-linux-musleabihf/bin  

    mkdir -p build/repackaged/just-{{version}}-x86_64-apple-darwin/bin
    mv build/repackaged/just-{{version}}-x86_64-apple-darwin/just* build/repackaged/just-{{version}}-x86_64-apple-darwin/bin  

    mkdir -p build/repackaged/just-{{version}}-x86_64-pc-windows-msvc/bin
    mv build/repackaged/just-{{version}}-x86_64-pc-windows-msvc/just* build/repackaged/just-{{version}}-x86_64-pc-windows-msvc/bin  

    mkdir -p build/repackaged/just-{{version}}-x86_64-unknown-linux-musl/bin
    mv build/repackaged/just-{{version}}-x86_64-unknown-linux-musl/just* build/repackaged/just-{{version}}-x86_64-unknown-linux-musl/bin  

final version:
    rm -rf build/final
    mkdir -p build/final 

    tar czf build/final/just-{{version}}-aarch64-apple-darwin.tar.gz build/repackaged/just-{{version}}-aarch64-apple-darwin
    tar czf build/final/just-{{version}}-aarch64-unknown-linux-musl.tar.gz build/repackaged/just-{{version}}-aarch64-unknown-linux-musl
    tar czf build/final/just-{{version}}-arm-unknown-linux-musleabihf.tar.gz build/repackaged/just-{{version}}-arm-unknown-linux-musleabihf
    tar czf build/final/just-{{version}}-armv7-unknown-linux-musleabihf.tar.gz build/repackaged/just-{{version}}-armv7-unknown-linux-musleabihf
    tar czf build/final/just-{{version}}-x86_64-apple-darwin.tar.gz build/repackaged/just-{{version}}-x86_64-apple-darwin
    tar czf build/final/just-{{version}}-x86_64-pc-windows-msvc.tar.gz build/repackaged/just-{{version}}-x86_64-pc-windows-msvc
    tar czf build/final/just-{{version}}-x86_64-unknown-linux-musl.tar.gz build/repackaged/just-{{version}}-x86_64-unknown-linux-musl

release version url platform:
    curl -X POST \
        -H "Consumer-Key: $CONSUMER_KEY" \
        -H "Consumer-Token: $CONSUMER_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        -d '{"candidate": "just", "version": "{{version}}", "url": "{{url}}"}' \
        https://vendors.sdkman.io/release