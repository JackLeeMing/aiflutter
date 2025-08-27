#!/bin/bash

# 自动签名 macOS 框架脚本
# 使用开发者证书对所有未签名的框架进行签名

# 设置开发者证书 (使用 Apple Development 证书)
DEVELOPER_CERT="Apple Development: Jaque Lee (RWA2CF837B)"

# 构建目录
BUILD_DIR="./build/macos/Build/Products/Debug/aiflutter.app/Contents/Frameworks"

# 检查构建目录是否存在
if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ 构建目录不存在: $BUILD_DIR"
    echo "请先运行 'fvm flutter build macos --debug' 或 'fvm flutter run -d macos'"
    exit 1
fi

echo "🔍 查找未签名的框架..."

# 未签名的框架列表
UNSIGNED_FRAMEWORKS=(
    "Ass.framework"
    "Avcodec.framework" 
    "Avfilter.framework"
    "Avformat.framework"
    "Avutil.framework"
    "Dav1d.framework"
    "Freetype.framework"
    "Fribidi.framework"
    "Harfbuzz.framework"
    "Mbedcrypto.framework"
    "Mbedtls.framework"
    "Mbedx509.framework"
    "Mpv.framework"
    "Png16.framework"
    "Swresample.framework"
    "Swscale.framework"
    "Uchardet.framework"
    "Xml2.framework"
)

echo "📝 开始签名框架..."

# 签名计数器
signed_count=0
failed_count=0

for framework in "${UNSIGNED_FRAMEWORKS[@]}"; do
    framework_path="$BUILD_DIR/$framework"
    
    if [ -d "$framework_path" ]; then
        echo "🔐 正在签名: $framework"
        
        # 获取框架名称（去掉.framework后缀）
        framework_name=$(basename "$framework" .framework)
        executable_path="$framework_path/$framework_name"
        
        # 检查可执行文件是否存在
        if [ -f "$executable_path" ]; then
            # 直接签名可执行文件
            if codesign --force --sign "$DEVELOPER_CERT" "$executable_path"; then
                echo "✅ 成功签名: $framework"
                ((signed_count++))
            else
                echo "❌ 签名失败: $framework"
                ((failed_count++))
            fi
        else
            echo "⚠️  可执行文件不存在: $executable_path"
            ((failed_count++))
        fi
    else
        echo "⚠️  框架不存在: $framework"
        ((failed_count++))
    fi
done

echo ""
echo "📊 签名结果:"
echo "✅ 成功签名: $signed_count 个框架"
echo "❌ 签名失败: $failed_count 个框架"

if [ $failed_count -eq 0 ]; then
    echo ""
    echo "🎉 所有框架签名完成！现在可以运行应用了。"
    echo "运行命令: fvm flutter run -d macos"
else
    echo ""
    echo "⚠️  部分框架签名失败，请检查证书配置。"
fi