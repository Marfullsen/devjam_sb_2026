# 🎮 Verlet Rope for Godot 4

This project is a direct translation of the original Verlet Rope logic from C# to GDScript.

![Verlet Rope Demo](./misc/verlet_rope_4_gd.gif)

## 👏 Credits

All credits and regards should go to the original project:
https://github.com/Tshmofen/verlet-rope-4

## ✨ Features

- 🧵 Direct translation of the original C# implementation to GDScript
- 🔗 Special feature: Ability to attach objects to the end of the rope with position and rotation support

> 🚨 **Note:** The object attachment feature supports both position and rotation control. You can toggle whether attached objects should follow the rope's orientation using the `rotate_attached_object` property. These features are being developed based on the needs of specific projects, so they may or may not be useful for your particular use case. Regardless, the core functionality of the original project has been successfully ported to GDScript.
>
> 💡 If the current functionality doesn't suit your needs, feel free to explore older commits, open an issue, or contact me directly at [purpltie@outlook.com](mailto:purpltie@outlook.com).

## 📥 Installation

1. 📋 Clone or download this repository
2. 📁 Copy the `verlet_rope_4_gd` directory into the `addons/` subdirectory of your Godot project
3. ✅ The addon is now ready to use in your project

## 📚 Usage

1. ➕ Add the VerletRope node to your scene
2. ⚙️ Configure the rope parameters through the Editor

## 🔧 Implementation

This addon implements a verlet-based rope physics system for Godot, focusing on maintaining the same functionality as the original while adapting to Godot's environment and coding patterns.

## 🤝 Contributions

Thoughts, criticism, suggestions, and contributions are welcome! Feel free to:

- 🐛 Open issues for bugs or feature requests
- 🔀 Submit pull requests with improvements
- 💬 Share your experience using this addon

All feedback is appreciated and will help improve this Godot addon.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

### Contributors:
- **Oleksander [@sanyabeast](https://github.com/sanyabeast) Haivoronskyi** - C# to GDScript translation with additional features
- **Timofey [@tshmofen](https://github.com/tshmofen) Ivanov** - 2024 - *Current Maintainer*
- **Zae [@zaevi](https://github.com/zaevi) Chao** - 2023 
- **Shashank C** - 2021 - Original work
 