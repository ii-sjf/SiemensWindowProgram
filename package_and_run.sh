#!/bin/bash

# 打包并运行西门子通讯程序，启用中文支持

echo "开始打包项目..."
mvn clean package -Dmaven.test.skip=true

if [ $? -eq 0 ]; then
    echo "打包成功，创建可执行的JAR文件..."

    # 创建可执行脚本
    cat > run_app.sh << 'EOF'
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检测系统架构
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH="x64"
        ;;
    aarch64)
        ARCH="aarch64"
        ;;
    *)
        ARCH="x64"
        ;;
esac

# 检测操作系统
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# 设置JVM参数以支持中文
export _JAVA_OPTIONS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Dsun.java2d.opengl=false"

# 尝试多种方式运行应用程序
if command -v java &> /dev/null; then
    # 方式1：直接运行JAR
    java -Dfile.encoding=UTF-8 \
         -Dsun.jnu.encoding=UTF-8 \
         -Dsun.java2d.opengl=false \
         -Dprism.order=sw \
         -Dprism.forceGPU=false \
         -cp "target/SiemensWindowProgram-jar-with-dependencies.jar:$(find /usr/share/openjfx/lib -name '*.jar' | tr '\n' ':')" \
         com.znh.siemens.StartApplication
else
    echo "错误：未找到Java运行时环境"
    exit 1
fi
EOF

    chmod +x run_app.sh
    echo "打包完成，运行 ./run_app.sh 来启动应用程序"
else
    echo "打包失败，请检查错误信息"
fi