# appupgrade

A plugin of app upgrade

## Getting Started

功能和插件[flutter_app_upgrade](https://pub.flutter-io.cn/packages/flutter_app_upgrade)，flutter_app_upgrade使用和swift开发，本插件包使用Java和OC进行改写。
具体功能可参考[flutter_app_upgrade](https://pub.flutter-io.cn/packages/flutter_app_upgrade)。

## 新增文件下载配置xml
文件位置: `xml/file_paths.xml`
```
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-path name="root" path="Android/data/com.xiangrui.baozhang/files" />
</paths>

```
在`AndroidManifest`中添加配置
```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools"
    package="com.xiangrui.baozhang">
   <application>

    <!-- 安装更新Start -->
        <provider
                android:name="androidx.core.content.FileProvider"
                android:authorities="com.xiangrui.baozhang.fileprovider"
                android:exported="false"
                android:grantUriPermissions="true">
            <meta-data
                    android:name="android.support.FILE_PROVIDER_PATHS"
                    tools:replace="android:resource"
                    android:resource="@xml/file_paths" />
        </provider>
    <!-- 安装更新End -->

    </application>
</manifest>
```
