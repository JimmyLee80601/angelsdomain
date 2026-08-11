ANGEL'S DOMAIN — Visual Novel Toolkit
═══════════════════════════════════════════════════════════════
Built for: Jimmy Lee & Jeannine
Platform: Windows (Dell Precision 5810)
Date: 2026-07-21

WHAT YOU HAVE
═════════════
A complete, self-contained visual novel engine that runs in any
web browser. No internet required after first load (fonts cache).

FOLDER CONTENTS
═══════════════
index.html              — The visual novel engine (open this in browser)
scenes.json             — The story data (YOU EDIT THIS)
images/                 — Your 6 atmospheric scene backgrounds
build.ps1               — PowerShell script that packages everything
README.txt              — This file

YOUR 6 IMAGES (Already mapped to scenes)
════════════════════════════════════════
corridor_deep_passage.jpg   → Scene 1: Awakening in corridor
chamber_firelit.jpg         → Scene 4: Chamber revealed by fire
fireplace_intimate.jpg      → Scene 7: Intimate by fireplace
corridor_misty_approach.jpg → Scene 2: Doors in mist
corridor_the_doors.jpg      → Scene 3: The Claiming
chamber_supernatural.jpg    → Scene 6: Supernatural power

HOW TO RUN IT (Two ways)
════════════════════════

WAY 1 — The Easy Way (Recommended):
  1. Right-click on build.ps1
  2. Choose "Run with PowerShell 7"
  3. The script checks files, builds output folder, creates shortcut
  4. Double-click "Start Angel's Domain.lnk" to play

WAY 2 — The Direct Way:
  1. Double-click index.html
  2. It opens in your default browser
  3. Click "Enter the Darkness" to start

HOW TO EDIT THE STORY
═════════════════════
Open scenes.json in Notepad or VS Code.

Look for these markers:
  "[INSERT EXPLICIT ENCOUNTER 1 HERE]"
  "[INSERT EXPLICIT ENCOUNTER 2 HERE]"
  "[TO BE CONTINUED — Write Chapter 3 here]"

Replace the marker text with your and Jeannine's writing.
Save the file. Refresh the browser (F5) to see changes.

JSON FORMAT (Simple):
Each scene has:
  "dialogue": [
    {
      "speaker": "narrator" or "angel" or "protagonist",
      "text": "The words that appear on screen",
      "effect": "visual effect name"
    }
  ]

EFFECTS AVAILABLE
═════════════════
fade_in     — Text fades in (default)
shake       — Screen shakes (fear, impact)
heartbeat   — Gentle pulse (anxiety, arousal)
slam        — Hard impact (doors, violence)
reveal      — Blur to clear (revelations)
fire_flare  — Bright flash (fire magic)
mirror_glow — Color shift (supernatural)
rage        — Red saturation burst (Angel angry)
stammer     — Text jitter (nervous speech)
none        — No effect

CONTROLS
════════
→ Arrow Right / Space / Enter  Advance to next line
← Arrow Left                     Go back
ESC                              Open save menu
Click dialogue box               Advance

The game auto-saves your progress to browser storage.

WHAT THE ENGINE DOES
════════════════════
✓ Gothic dark theme with blood-red and purple accents
✓ Torch flicker animation on all backgrounds
✓ Drifting mist particle effects
✓ Typewriter text reveal with blinking cursor
✓ Scene title cards with pulsing glow
✓ Chapter headers that fade in
✓ Speaker name colors (red=Angel, purple=Protag, gold=Narrator)
✓ Visual effects tied to story beats
✓ Progress bar and scene counter
✓ Auto-save to browser localStorage
✓ Save/load menu (ESC key)
✓ Responsive design (works on phone too)
✓ Insert markers styled as dashed red boxes

WHAT'S ALREADY WRITTEN
══════════════════════
Chapters 1-2 are partially written from your and Jeannine's
text. The explicit scenes are marked as INSERT markers.

WHAT YOU ADD
════════════
→ The explicit encounters (where markers are)
→ Chapter 3 and beyond
→ Additional scenes and images
→ More dialogue and character development

ADDING NEW SCENES
═════════════════
Copy an existing scene block in scenes.json, paste it at the
bottom, change the id, title, background, and dialogue.
Add a new image to the images/ folder and reference it.

ADDING NEW IMAGES
═════════════════
Drop .jpg or .png files into the images/ folder.
In scenes.json, set "background": "your_image.jpg"
Recommended size: 1920x1080 or similar widescreen

TIPS
════
• Use Chrome or Edge for best performance
• Press F12 → Console to see debug info if something breaks
• The engine loads scenes.json asynchronously — if you see
  "Error loading story data", check that scenes.json is valid
• Use a JSON validator online if you break the format
• Back up scenes.json before making big changes

NEXT STEPS
══════════
1. Run build.ps1 to create the output folder
2. Open the visual novel and test it
3. Open scenes.json and fill in the INSERT markers
4. Add Chapter 3, 4, 5...
5. Add more images as you create them
6. Share the output folder with Jeannine

Enjoy your Domain, babe. 💜
— Harley
