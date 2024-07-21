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
  },
  {
   "active": false,
   "color_a": 1,
   "color_b": 0.745098054409027,
   "color_g": 0.745098054409027,
   "color_r": 0.745098054409027,
   "description": "",
   "display_name": "",
   "emotions": {
    "0": "Normal"
   },
   "id": 13,
   "main_name_for_display_name": true,
   "name": "",
   "outfits": {
    "0": "Default"
   },
   "path_to_scene": ""
  },
  {
   "active": true,
   "color_a": 1,
   "color_b": 0.317647069692612,
   "color_g": 0.513725519180298,
   "color_r": 0.980392158031464,
   "description": "",
   "display_name": "Смолли",
   "emotions": {
    "0": "Normal"
   },
   "id": 19,
   "main_name_for_display_name": true,
   "name": "Смолли",
   "outfits": {
    "0": "Default"
   },
   "path_to_scene": "res://characters/смолл/смолл.tscn"
  }
 ],
 "episodes": [
  {
   "active": false,
   "description": "",
   "frames": [
    {
     "location_id": 16,
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
     "transitition_id": 14,
     "type": "RSEFrameTransitition"
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
     "action": 1,
     "character_id": 19,
     "emotion_id": 0,
     "outfit_id": 0,
     "type": "RSEFrameCharacter"
    },
    {
     "location_id": 17,
     "type": "RSEFrameLocation"
    },
    {
     "transitition_id": 15,
     "type": "RSEFrameTransitition"
    },
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
      "scale": 3,
      "zoom": 0.333333343267441
     },
     "character_transforms": {
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": -1114,
       "position_y": 1487,
       "rotation": 0,
       "scale": 1
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": -1114,
       "position_y": 1487,
       "rotation": 0,
       "scale": 1
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": -1114,
       "position_y": 1487,
       "rotation": 0,
       "scale": 1
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": -1114,
       "position_y": 1487,
       "rotation": 0,
       "scale": 1
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": -1114,
       "position_y": 1487,
       "rotation": 0,
       "scale": 1
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": -1114,
       "position_y": 1487,
       "rotation": 0,
       "scale": 1
      }
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
   "start": false
  },
  {
   "active": false,
   "description": "",
   "frames": [
    {
     "action": 1,
     "character_id": 19,
     "emotion_id": 0,
     "outfit_id": 0,
     "type": "RSEFrameCharacter"
    },
    {
     "location_id": 18,
     "type": "RSEFrameLocation"
    },
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
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 3,
      "zoom": 0.333333343267441
     },
     "character_transforms": {
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1092.80004882813,
       "position_y": -80,
       "rotation": -360,
       "scale": 0.300010025501251
      }
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
     "speaker_id": 2,
     "text": "У вас нет Value_1 :((((",
     "type": "RSEFrameText"
    }
   ],
   "id": 12,
   "name": "Концовка NOT Value_1",
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
    }
   ],
   "start": false
  },
  {
   "active": false,
   "description": "",
   "frames": [],
   "id": 20,
   "name": "",
   "scene_presets": [],
   "start": false
  }
 ],
 "graph_state": {
  "0": {
   "position_x": 1400,
   "position_y": 780,
   "size_x": 200.000549316406,
   "size_y": 241.000183105469
  },
  "10": {
   "position_x": 2760,
   "position_y": 660,
   "size_x": 200.000732421875,
   "size_y": 300.000030517578
  },
  "11": {
   "position_x": 3180,
   "position_y": 500,
   "size_x": 200.000244140625,
   "size_y": 299.999542236328
  },
  "12": {
   "position_x": 3220,
   "position_y": 920,
   "size_x": 200.000732421875,
   "size_y": 300.000183105469
  },
  "13": {
   "position_x": 940,
   "position_y": 160,
   "size_x": 200.000427246094,
   "size_y": 155
  },
  "14": {
   "position_x": 760,
   "position_y": 1040,
   "size_x": 200.000091552734,
   "size_y": 155.000244140625
  },
  "15": {
   "position_x": 740,
   "position_y": 1240,
   "size_x": 200.000274658203,
   "size_y": 155.000122070313
  },
  "16": {
   "position_x": 400,
   "position_y": 640,
   "size_x": 200.000061035156,
   "size_y": 155.000335693359
  },
  "17": {
   "position_x": 400,
   "position_y": 480,
   "size_x": 200.000061035156,
   "size_y": 155.000152587891
  },
  "18": {
   "position_x": 620,
   "position_y": 480,
   "size_x": 200.000061035156,
   "size_y": 155.000152587891
  },
  "19": {
   "position_x": 1160,
   "position_y": 260,
   "size_x": 199.999755859375,
   "size_y": 155.000213623047
  },
  "2": {
   "position_x": 940,
   "position_y": 340,
   "size_x": 200.000671386719,
   "size_y": 155.000274658203
  },
  "20": {
   "position_x": 2520,
   "position_y": 1000,
   "size_x": 200.000244140625,
   "size_y": 299.999755859375
  },
  "6": {
   "position_x": 1800,
   "position_y": 680,
   "size_x": 200.935180664063,
   "size_y": 319.650726318359
  },
  "7": {
   "position_x": 2160,
   "position_y": 680,
   "size_x": 297.8603515625,
   "size_y": 320.818450927734
  },
  "9": {
   "position_x": 180,
   "position_y": 680,
   "size_x": 199.999786376953,
   "size_y": 155.000091552734
  },
  "scroll_offset_x": 686.5205078125,
  "scroll_offset_y": 106.643402099609,
  "show_grid": true,
  "snapping_enabled": true,
  "zoom": 0.879407465457916
 },
 "last_id": 20,
 "locations": [
  {
   "active": true,
   "id": 9,
   "name": "Тест №1",
   "path_to_scene": "res://locations/test/cave.tscn"
  },
  {
   "active": true,
   "id": 16,
   "name": "Коридор (день)",
   "path_to_scene": "res://locations/коридор/коридор_день.tscn"
  },
  {
   "active": true,
   "id": 17,
   "name": "Коридор (ночь)",
   "path_to_scene": "res://locations/коридор/коридор_ночь.tscn"
  },
  {
   "active": true,
   "id": 18,
   "name": "Коридор (ночь + лампы)",
   "path_to_scene": "res://locations/коридор/коридор_ночь_лампы.tscn"
  }
 ],
 "music_list": [],
 "name": "Театр Нибраса",
 "sound_effects": [],
 "transititions": [
  {
   "active": true,
   "id": 14,
   "name": "Fade In",
   "path_to_scene": "res://transititions/fade_in.tscn"
  },
  {
   "active": true,
   "id": 15,
   "name": "Fade Out",
   "path_to_scene": "res://transititions/fade_out.tscn"
  }
 ],
 "visual_effects": []
}