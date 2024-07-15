{
 "characters": [
  {
   "active": true,
   "color_a": 1,
   "color_b": 0.188690185546875,
   "color_g": 0.89453125,
   "color_r": 0.822844266891479,
   "description": "",
   "display_name": "Рассказчик",
   "emotions": {
    "0": "Normal"
   },
   "id": 2,
   "main_name_for_display_name": true,
   "name": "Рассказчик",
   "outfits": {
    "0": "Default"
   },
   "path_to_scene": ""
  }
 ],
 "episodes": [
  {
   "active": false,
   "description": "",
   "frames": [
    {
     "action": 1,
     "character_id": 2,
     "emotion_id": 0,
     "outfit_id": 0,
     "type": "RSEFrameCharacter"
    },
    {
     "speaker_id": 2,
     "text": "Это начало тестового эпизода.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 2,
     "text": "Рассказчик продолжает говорить.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 2,
     "text": "... И говорить.",
     "type": "RSEFrameText"
    },
    {
     "description": "",
     "to_episode_id": 7,
     "type": "RSEFrameJump"
    }
   ],
   "id": 6,
   "name": "1",
   "scene_presets": [
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1,
      "zoom": 1
     },
     "character_transforms": {

     },
     "location_transform": {

     },
     "visual_effects_transforms": {

     }
    },
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1,
      "zoom": 1
     },
     "character_transforms": {

     },
     "location_transform": {

     },
     "visual_effects_transforms": {

     }
    },
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1,
      "zoom": 1
     },
     "character_transforms": {

     },
     "location_transform": {

     },
     "visual_effects_transforms": {

     }
    },
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1,
      "zoom": 1
     },
     "character_transforms": {

     },
     "location_transform": {

     },
     "visual_effects_transforms": {

     }
    }
   ],
   "start": true
  },
  {
   "active": false,
   "description": "",
   "frames": [
    {
     "speaker_id": 2,
     "text": "Это второй эпизод.",
     "type": "RSEFrameText"
    },
    {
     "type": "RSEFrameGap"
    },
    {
     "speaker_id": 2,
     "text": "Тут только что был разрыв кадра.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 2,
     "text": "Такие дела.",
     "type": "RSEFrameText"
    },
    {
     "options": [
      [
       6,
       "Повторить прошлый эпизод"
      ],
      [
       8,
       "Проверка переноса строк"
      ],
      [
       7,
       "Повторить этот эпизод"
      ]
     ],
     "type": "RSEFrameSelection"
    }
   ],
   "id": 7,
   "name": "2",
   "scene_presets": [
    null,
    null,
    null,
    null,
    null
   ],
   "start": false
  },
  {
   "active": false,
   "description": "",
   "frames": [
    {
     "speaker_id": 2,
     "text": "Тут будет происходить проверка переноса слов в строке.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 2,
     "text": "Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово. Слово.",
     "type": "RSEFrameText"
    }
   ],
   "id": 8,
   "name": "Проверка переноса строк",
   "scene_presets": [
    null,
    null
   ],
   "start": false
  }
 ],
 "graph_state": {
  "0": {
   "position_x": 1400,
   "position_y": 780,
   "size_x": 200,
   "size_y": 241.000061035156
  },
  "2": {
   "position_x": 1000,
   "position_y": 640,
   "size_x": 200.000061035156,
   "size_y": 155.000061035156
  },
  "6": {
   "position_x": 1840,
   "position_y": 680,
   "size_x": 199.999877929688,
   "size_y": 300.000122070313
  },
  "7": {
   "position_x": 2200,
   "position_y": 680,
   "size_x": 199.999755859375,
   "size_y": 306
  },
  "8": {
   "position_x": 2620,
   "position_y": 660,
   "size_x": 303.037353515625,
   "size_y": 353.217132568359
  },
  "scroll_offset_x": 663.459350585938,
  "scroll_offset_y": -25.1303100585938,
  "show_grid": true,
  "snapping_enabled": true,
  "zoom": 0.72989809513092
 },
 "last_id": 8,
 "locations": [],
 "music_list": [],
 "name": "Иск за рис без риска",
 "sound_effects": [],
 "transititions": [],
 "visual_effects": []
}