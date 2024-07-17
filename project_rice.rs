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
     "location_id": 9,
     "transitition_id": 0,
     "type": "RSEFrameLocation"
    },
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
      "scale": 3,
      "zoom": 0.333333343267441
     },
     "character_transforms": {

     },
     "location_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1
     },
     "visual_effects_transforms": {

     }
    },
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 3,
      "zoom": 0.333333343267441
     },
     "character_transforms": {

     },
     "location_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1
     },
     "visual_effects_transforms": {

     }
    },
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 3,
      "zoom": 0.333333343267441
     },
     "character_transforms": {

     },
     "location_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1
     },
     "visual_effects_transforms": {

     }
    },
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 3,
      "zoom": 0.333333343267441
     },
     "character_transforms": {

     },
     "location_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 1
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
       10,
       "Проверка условий"
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
   "start": false
  },
  {
   "active": false,
   "description": "",
   "frames": [
    {
     "global": false,
     "name": "Value_1",
     "type": "RSEFrameVariable",
     "value": ""
    },
    {
     "speaker_id": 2,
     "text": "Проверка условий.",
     "type": "RSEFrameText"
    },
    {
     "condition": "Value_1",
     "global": false,
     "type": "RSEFrameCondition"
    },
    {
     "speaker_id": 2,
     "text": "Если ЕСТЬ Value_1, то будет показан этот текст.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 2,
     "text": "Ла-ла-ла...",
     "type": "RSEFrameText"
    },
    {
     "description": "Если ЕСТЬ Value_1",
     "to_episode_id": 11,
     "type": "RSEFrameJump"
    },
    {
     "type": "RSEFrameEndCondition"
    },
    {
     "condition": "NOT Value_1",
     "global": false,
     "type": "RSEFrameCondition"
    },
    {
     "speaker_id": 2,
     "text": "Если Value_1 НЕТ, то будет показан этот текст.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 2,
     "text": "Бе-бе-бе...",
     "type": "RSEFrameText"
    },
    {
     "description": "Если Value_1 НЕТ",
     "to_episode_id": 12,
     "type": "RSEFrameJump"
    },
    {
     "type": "RSEFrameEndCondition"
    },
    {
     "speaker_id": 2,
     "text": "Конец проверки условий.",
     "type": "RSEFrameText"
    }
   ],
   "id": 10,
   "name": "Проверка условий",
   "scene_presets": [
    null,
    null,
    null,
    null,
    null,
    null,
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
     "text": "У вас есть Value_1! Замечательно.",
     "type": "RSEFrameText"
    }
   ],
   "id": 11,
   "name": "Концовка Value_1",
   "scene_presets": [
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
     "text": "У вас нет Value_1 :((((",
     "type": "RSEFrameText"
    }
   ],
   "id": 12,
   "name": "Концовка NOT Value_1",
   "scene_presets": [
    null
   ],
   "start": false
  }
 ],
 "graph_state": {
  "0": {
   "position_x": 1400,
   "position_y": 780,
   "size_x": 199.999572753906,
   "size_y": 241.000030517578
  },
  "10": {
   "position_x": 2760,
   "position_y": 660,
   "size_x": 200,
   "size_y": 300.000122070313
  },
  "11": {
   "position_x": 3180,
   "position_y": 500,
   "size_x": 200,
   "size_y": 300
  },
  "12": {
   "position_x": 3220,
   "position_y": 920,
   "size_x": 200,
   "size_y": 299.999969482422
  },
  "2": {
   "position_x": 1000,
   "position_y": 640,
   "size_x": 200.000244140625,
   "size_y": 155.000152587891
  },
  "6": {
   "position_x": 1800,
   "position_y": 680,
   "size_x": 200.935729980469,
   "size_y": 319.650848388672
  },
  "7": {
   "position_x": 2160,
   "position_y": 680,
   "size_x": 297.861328125,
   "size_y": 320.818695068359
  },
  "9": {
   "position_x": 760,
   "position_y": 820,
   "size_x": 200,
   "size_y": 155.000274658203
  },
  "scroll_offset_x": 701.120361328125,
  "scroll_offset_y": 158.882843017578,
  "show_grid": true,
  "snapping_enabled": true,
  "zoom": 0.726783752441406
 },
 "last_id": 12,
 "locations": [
  {
   "active": true,
   "id": 9,
   "name": "Тест №1",
   "path_to_scene": "res://locations/test/cave.tscn"
  }
 ],
 "music_list": [],
 "name": "Иск за рис без риска",
 "sound_effects": [],
 "transititions": [],
 "visual_effects": []
}