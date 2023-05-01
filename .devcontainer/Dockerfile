FROM dart

RUN apt-get update
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa

RUN apt-get clean

# flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:$PATH"
RUN flutter doctor

RUN apt install -y \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev

# dev tools
RUN apt-get install -y vim zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"