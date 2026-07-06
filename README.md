# Small Caps Converter

This project is a Haskell command-line utility. This tool parses Text, YAML, and Properties files, converting standard alphabetical strings into Unicode ꜱᴍᴀʟʟ ᴄᴀᴘꜱ while safely ignoring numbers, booleans, nulls, and punctuation.

## 🏗️ Project Structure

The codebase follows the following structure:

```text
small-caps-converter/
├── app/
│   └── Main.hs                  # CLI entry point with pure list pattern matching for argument routing
├── src/
│   ├── Converters/
│   │   ├── TextConverter.hs       # Safe IO pipeline enforcing UTF-8 encoding
│   │   ├── YamlConverter.hs       # Recursive AST walker using fmap and Aeson
│   │   └── PropertiesConverter.hs # Raw byte-stream processor bypassing OS text encoders
│   └── Core/
│       └── SmallCaps.hs         # Point-free character mapping dictionary
├── data/                        # Default directory for file inputs and outputs
├── test/                        
│   ├── Spec.hs                  # Test suite to make sure everything works fine
└── small-caps-converter.cabal   # Package and build configuration
```

## 🚀 Getting Started

### Prerequisites
You will need the Haskell toolchain installed on your system (GHC and Cabal). The easiest way to get this is via [GHCup](https://www.haskell.org/ghcup/).

### Installation
1. Clone the repository to your local machine:
   ```bash
   git clone [https://github.com/aliien15/Small-Caps-Converter](https://github.com/aliien15/Small-Caps-Converter)
   cd small-caps-converter
   ```
2. Build the executable using Cabal:
   ```bash
   cabal build
   ```

## 💻 Usage

The application is designed with UX in mind. You **do not** need to type out folder paths or file extensions. The program automatically routes all file lookups to the `data/` folder and intelligently appends `.txt`, `.yaml` or `.properties` based on the command you run.

**Syntax:**
```bash
cabal run small-caps-converter -- <text|yaml|properties> <input_filename> <output_filename>
```

---

## 📝 Examples

Make sure your input files are placed inside the `data/` folder before running the commands.

### 1. Converting a Text File

Create a file named `input.txt` inside the `data/` folder:
```text
Hello World! 
This is a test of the purely functional Haskell converter.

Does it handle uppercase? YES.
Does it handle lowercase? yes.
Does it ignore numbers like 12345 and punctuation?!
```

**Run the command:**
```bash
cabal run small-caps-converter -- text input output
```

**Output (`data/output.txt`):**
```text
Hᴇʟʟᴏ Wᴏʀʟᴅ! 
Tʜɪꜱ ɪꜱ ᴀ ᴛᴇꜱᴛ ᴏꜰ ᴛʜᴇ ᴘᴜʀᴇʟʏ ꜰᴜɴᴄᴛɪᴏɴᴀʟ Hᴀꜱᴋᴇʟʟ ᴄᴏɴᴠᴇʀᴛᴇʀ.

Dᴏᴇꜱ ɪᴛ ʜᴀɴᴅʟᴇ ᴜᴘᴘᴇʀᴄᴀꜱᴇ? YES.
Dᴏᴇꜱ ɪᴛ ʜᴀɴᴅʟᴇ ʟᴏᴡᴇʀᴄᴀꜱᴇ? ʏᴇꜱ.
Dᴏᴇꜱ ɪᴛ ɪɢɴᴏʀᴇ ɴᴜᴍʙᴇʀꜱ ʟɪᴋᴇ 12345 ᴀɴᴅ ᴘᴜɴᴄᴛᴜᴀᴛɪᴏɴ?!
```

### 2. Converting a YAML File

This command recursively traverses the Abstract Syntax Tree (AST), ensuring that integers, booleans, and null values are completely ignored while safely converting all deeply nested strings.

Create a file named `config.yaml` inside the `data/` folder:
```yaml
# Core Plugin Configuration
plugin_data:
  name: "Test Module"
  version: 2.1
  enabled: true
  debug_mode: null

# Messaging System
messages:
  prefix: "System Warning"
  welcome: "Welcome back to the server!"
  error_not_found: "Error: Target entity could not be located."

# Active Systems
modules:
  - "DiscordWebhooks"
  - "Time Formatting"
  - "Database Manager"

# Deep Nesting Test
advanced_settings:
  database:
    pool_size: 1
    async_writes: true
    credentials:
      user: "adminUser"
      pass: "SuperSecretPassword123!"
```

**Run the command:**
```bash
cabal run small-caps-converter -- yaml config new-config
```

**Output (`data/new-config.yaml`):**
```yaml
advanced_settings:
  database:
    async_writes: true
    credentials:
      pass: ꜱᴜᴘᴇʀꜱᴇᴄʀᴇᴛᴘᴀꜱꜱᴡᴏʀᴅ123!
      user: ᴀᴅᴍɪɴᴜꜱᴇʀ
    pool_size: 1
messages:
  error_not_found: 'ᴇʀʀᴏʀ: ᴛᴀʀɢᴇᴛ ᴇɴᴛɪᴛʏ ᴄᴏᴜʟᴅ ɴᴏᴛ ʙᴇ ʟᴏᴄᴀᴛᴇᴅ.'
  prefix: ꜱʏꜱᴛᴇᴍ ᴡᴀʀɴɪɴɢ
  welcome: ᴡᴇʟᴄᴏᴍᴇ ʙᴀᴄᴋ ᴛᴏ ᴛʜᴇ ꜱᴇʀᴠᴇʀ!
modules:
- ᴅɪꜱᴄᴏʀᴅᴡᴇʙʜᴏᴏᴋꜱ
- ᴛɪᴍᴇ ꜰᴏʀᴍᴀᴛᴛɪɴɢ
- ᴅᴀᴛᴀʙᴀꜱᴇ ᴍᴀɴᴀɢᴇʀ
plugin_data:
  debug_mode: null
  enabled: true
  name: ᴛᴇꜱᴛ ᴍᴏᴅᴜʟᴇ
  version: 2.1
```

### 3. Converting a Properties File

This command processes `.properties` configurations line-by-line. It safely manages system encoding overrides, maintains all empty space, preserves `#` and `!` comments, keeps your keys completely intact, and standardizes key-value delimiters to `=` while converting the target string values.

Create a file named `settings.properties` inside the `data/` folder:
```properties
# ==========================================
# Haskell Small Caps Converter - Test File
# ==========================================

! Server Settings
server.host=localhost
server.port:8080
server.environment=production

! External Integrations
api.endpoint.url=[https://api.example.com/v1/data](https://api.example.com/v1/data)
api.auth.token:secret_token_12345

# Message Configurations
message.greeting=Welcome to the application!
message.math.hint=Remember that E=mc^2.
```

**Run the command:**
```bash
cabal run small-caps-converter -- properties settings new-settings
```

**Output (`data/new-settings.properties`):**
```properties
# ==========================================
# Haskell Small Caps Converter - Test File
# ==========================================

! Server Settings
server.host=ʟᴏᴄᴀʟʜᴏꜱᴛ
server.port=8080
server.environment=ᴘʀᴏᴅᴜᴄᴛɪᴏɴ

! External Integrations
api.endpoint.url=ʜᴛᴛᴘꜱ://ᴀᴘɪ.ᴇxᴀᴍᴘʟᴇ.ᴄᴏᴍ/ᴠ1/ᴅᴀᴛᴀ
api.auth.token=ꜱᴇᴄʀᴇᴛ_ᴛᴏᴋᴇɴ_12345

# Message Configurations
message.greeting=Wᴇʟᴄᴏᴍᴇ ᴛᴏ ᴛʜᴇ ᴀᴘᴘʟɪᴄᴀᴛɪᴏɴ!
message.math.hint=Rᴇᴍᴇᴍʙᴇʀ ᴛʜᴀᴛ E=ᴍᴄ^2.
```