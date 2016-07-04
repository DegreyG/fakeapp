# iOS fake app

----------------

A tool for creating "iOS Fake App" project. You can Debug & Profile any decrypted iOS app without any jailbreak devices.

## Usage

### Step 1. Create fakeapp

```sh
bin/fakeapp [APPNAME]
```

### Step 2. Prepare Payload

```
cd [FakeAppDir]
cp [YourDecryptedApp].ipa ./
unzip [YourDecryptedApp].ipa
```

Or move your `[AppName].app` to `[FakeAppDir]/Payload/`.

### Step 3. Setup Codesign

Now, open `[AppName].xcodeproj` and setup your codesign Identity & Provision in `Build Settings`. You need to setup both `[AppName]` and `PDebug` targets;

### Step 4. Run & Debug

Just run and enjoy it. You can do any `DEBUG` actions like `Breakpoints` `Step-in/out` `LLDB` `Threads` `Profile` `Simulate Location`.

## PDebug - Code inject

**fakeapp** already injected an `Embed Dynamic Framework` named `PDebug.framework`, You can add some code here and these code will be run with main app.

```objc
@implementation PDebugEntry

+(void)load
{
	// add your code here
	NSLog("PDebug injected.");
}

@end
```

## License

The MIT License (MIT)
