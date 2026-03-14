# ใช้ Rust official image
FROM rust:1.76

# สร้าง working directory
WORKDIR /app

# copy source code
COPY . .

# build project
RUN cargo build --release

# run program
CMD ["./target/release/rust-menger"]