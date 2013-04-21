rm -rf icon.iconset
mkdir icon.iconset
sips -z 16 16 --out icon.iconset/icon_16x16.png $1 
sips -z 32 32 --out icon.iconset/icon_16x16@2x.png $1
sips -z 32 32 --out icon.iconset/icon_32x32.png $1
sips -z 64 64 --out icon.iconset/icon_32x32@2x.png $1
sips -z 128 128 --out icon.iconset/icon_128x128.png $1
sips -z 256 256 --out icon.iconset/icon_128x128@2x.png $1
sips -z 256 256 --out icon.iconset/icon_256x256.png $1
sips -z 512 512 --out icon.iconset/icon_256x256@2x.png $1
sips -z 512 512 --out icon.iconset/icon_512x512.png $1
sips -z 1024 1024 --out icon.iconset/icon_512x512@2x.png $1
iconutil -c icns icon.iconset
rm -rf icon.iconset
