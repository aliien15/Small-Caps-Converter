# Small Caps Converter

This project is a Haskell command-line utility. This tool parses Text and YAML files, converting standard alphabetical strings into Unicode ꜱᴍᴀʟʟ ᴄᴀᴘꜱ while safely ignoring numbers, booleans, nulls, and punctuation.

## 🏗️ Project Structure

The codebase follows the following strcuture:

```text
small-caps-converter/
├── app/
│   └── Main.hs                  # CLI entry point with pure list pattern matching for argument routing
├── src/
│   ├── Converters/
│   │   ├── TextConverter.hs     # Safe IO pipeline enforcing UTF-8 encoding
│   │   └── YamlConverter.hs     # Recursive AST walker using fmap and Aeson
│   └── Core/
│       └── SmallCaps.hs         # Point-free character mapping dictionary
├── data/                        # Default directory for file inputs and outputs
│   ├── input.txt                # Example text file
│   └── config.yaml              # Example YAML file
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
   git clone https://github.com/aliien15/Small-Caps-Converter
   cd small-caps-converter
   ```
2. Build the executable using Cabal:
   ```bash
   cabal build
   ```

## 💻 Usage

The application is designed with UX in mind. You **do not** need to type out folder paths or file extensions. The program automatically routes all file lookups to the `data/` folder and intelligently appends `.txt` or `.yaml` based on the command you run.

**Syntax:**
```bash
cabal run small-caps-converter -- <text|yaml> <input_filename> <output_filename>
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
# Core Configuration
plugin_data:
  name: "Core Test Module"
  version: 2.1
  enabled: true
  debug_mode: null

# Deep Nesting Test
advanced_settings:
  database:
    pool_size: 1
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
plugin_data:
  name: "Cᴏʀᴇ Tᴇꜱᴛ Mᴏᴅᴜʟᴇ"
  version: 2.1
  enabled: true
  debug_mode: null
advanced_settings:
  database:
    pool_size: 1
    credentials:
      user: "ᴀᴅᴍɪɴUꜱᴇʀ"
      pass: "SᴜᴘᴇʀSᴇᴄʀᴇᴛPᴀꜱꜱᴡᴏʀᴅ123!"
```