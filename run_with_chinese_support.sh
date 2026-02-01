#!/bin/bash

# 解决JavaFX应用中文乱码问题的启动脚本
# 用于设置正确的字符编码

echo "启动西门子通讯程序，启用中文支持..."

# 设置Java虚拟机参数以支持中文
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Dawt.useSystemAAFontSettings=on"

# 运行JavaFX应用程序
java \
  -Dfile.encoding=UTF-8 \
  -Dsun.jnu.encoding=UTF-8 \
  -Dsun.awt.disableMixing=true \
  -Dprism.order=sw \
  -Dprism.forceGPU=false \
  -cp target/SiemensWindowProgram-1.0-SNAPSHOT.jar:/usr/share/openjfx/lib/javafx.base.jar:/usr/share/openjfx/lib/javafx.controls.jar:/usr/share/openjfx/lib/javafx.fxml.jar:/usr/share/openjfx/lib/javafx.graphics.jar:/usr/share/openjfx/lib/javafx.media.jar:/usr/share/openjfx/lib/javafx.swing.jar:/usr/share/openjfx/lib/javafx.web.jar \
  com.znh.siemens.StartApplication