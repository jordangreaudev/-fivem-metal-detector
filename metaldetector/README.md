# Metal Detector

<img width="1672" height="941" alt="metaldetector" src="https://github.com/user-attachments/assets/2d984bff-2728-4ab9-ab10-c2d80264f617" />

Portiques détecteurs de métaux via props : une alarme sonore se déclenche quand un joueur porteur d'une arme (ou de munitions) passe à proximité, sauf s'il appartient à un job whitelisté.

## Installation

1. Copier le dossier de la resource dans `resources/`.
2. Ajouter `ensure MetalDetector` (ou le nom du dossier) dans `server.cfg`.
3. Nécessite `ox_inventory` (déclaré en dépendance dans `fxmanifest.lua`).
4. Ajuster `config.lua` si besoin (voir ci-dessous).

## Configuration (`config.lua`)

- `Config.Framework` — `'auto'`, `'esx'`, `'qbcore'`, `'qbox'` ou `'standalone'`. Détermine comment le job du joueur est récupéré pour la whitelist. `'auto'` détecte la resource démarrée (`es_extended` / `qbx_core` / `qb-core`).
- `Config.WhitelistedJobs` — jobs non impactés par le portique (ex. `police`).
- `Config.TriggerDistance` / `Config.ScanInterval` — distance de déclenchement et fréquence de scan.
- `Config.DetectorProps` — modèles de props considérés comme des portiques.
- `Config.Sound`, `Config.SoundRepeatCount`, `Config.SoundRepeatDelay`, `Config.SoundHearDistance` — alarme jouée et diffusée aux joueurs à proximité.
- `Config.DetectedItems` — armes et munitions qui déclenchent l'alarme (noms `ox_inventory`).

---

