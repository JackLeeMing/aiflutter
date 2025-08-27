#!/bin/bash

# Post-build 签名脚本
# 在 Xcode 构建后自动运行

echo "🔧 Post-build: 开始签名未签名的框架..."

# 获取构建产物路径
APP_BUNDLE="$BUILT_PRODUCTS_DIR/$FULL_PRODUCT_NAME"
FRAMEWORKS_DIR="$APP_BUNDLE/Contents/Frameworks"

# 检查是否有开发者证书
if [ -z "$CODE_SIGN_IDENTITY" ]; then
    echo "⚠️ 没有代码签名身份，跳过签名"
    exit 0
fi

echo "📝 使用证书: $CODE_SIGN_IDENTITY"

# 需要签名的动态库
DYLIBS_TO_SIGN=(
    "Ass.framework/Ass"
    "Avcodec.framework/Avcodec" 
    "Avfilter.framework/Avfilter"
    "Avformat.framework/Avformat"
    "Avutil.framework/Avutil"
    "Dav1d.framework/Dav1d"
    "Freetype.framework/Freetype"
    "Fribidi.framework/Fribidi"
    "Harfbuzz.framework/Harfbuzz"
    "Mbedcrypto.framework/Mbedcrypto"
    "Mbedtls.framework/Mbedtls"
    "Mbedx509.framework/Mbedx509"
    "Mpv.framework/Mpv"
    "Png16.framework/Png16"
    "Swresample.framework/Swresample"
    "Swscale.framework/Swscale"
    "Uchardet.framework/Uchardet"
    "Xml2.framework/Xml2"
)

signed_count=0

for dylib in "${DYLIBS_TO_SIGN[@]}"; do
    dylib_path="$FRAMEWORKS_DIR/$dylib"
    
    if [ -f "$dylib_path" ]; then
        echo "🔐 签名: $dylib"
        # 使用 --preserve-metadata 保持现有元数据
        if /usr/bin/codesign --force --sign "$CODE_SIGN_IDENTITY" --preserve-metadata=identifier,entitlements,flags,runtime "$dylib_path" 2>/dev/null; then
            echo "✅ 成功: $dylib"
            ((signed_count++))
        else
            echo "⚠️ 失败: $dylib"
        fi
    fi
done

echo "🎉 完成！成功签名 $signed_count 个动态库"