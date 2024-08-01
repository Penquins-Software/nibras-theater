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
   "path_to_bleep_sound": "res://audio/bleep/low_blip_voice.wav",
   "path_to_scene": ""
  },
  {
   "active": true,
   "color_a": 1,
   "color_b": 0.081573486328125,
   "color_g": 0.081573486328125,
   "color_r": 0.7734375,
   "description": "",
   "display_name": "Беатриче",
   "emotions": {
    "0": "Normal"
   },
   "id": 13,
   "main_name_for_display_name": true,
   "name": "Беатриче",
   "outfits": {
    "0": "Default"
   },
   "path_to_bleep_sound": "res://audio/bleep/low_blip_synth.wav",
   "path_to_scene": "res://characters/беатричче/беатричче.tscn"
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
   "path_to_bleep_sound": "res://audio/bleep/low_blip_voice.wav",
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
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
     "music_id": 22,
     "type": "RSEFrameMusic"
    },
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
     "sound_id": 23,
     "status": false,
     "type": "RSEFrameSoundEffect"
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
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
      "21": {
       "id": 21,
       "position_x": 0,
       "position_y": 0,
       "rotation": 0,
       "scale": 1
      }
     }
    },
    {
     "camera_transform": {
      "position_x": 0,
      "position_y": 0,
      "rotation": 0,
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
      "scale": 2,
      "zoom": 0.5
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
     "music_id": 22,
     "type": "RSEFrameMusic"
    },
    {
     "action": 1,
     "character_id": 19,
     "emotion_id": 0,
     "outfit_id": 0,
     "type": "RSEFrameCharacter"
    },
    {
     "action": 1,
     "character_id": 13,
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
     "speaker_id": 13,
     "text": "Проверка условий.",
     "type": "RSEFrameText"
    },
    {
     "condition": "Value_1",
     "global": false,
     "type": "RSEFrameCondition"
    },
    {
     "speaker_id": 13,
     "text": "Если ЕСТЬ Value_1, то будет показан этот текст.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 13,
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
     "speaker_id": 13,
     "text": "Если Value_1 НЕТ, то будет показан этот текст.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 13,
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
      "position_x": 144,
      "position_y": -7,
      "rotation": 0,
      "scale": 1.80000019073486,
      "zoom": 0.555555522441864
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": 144,
      "position_y": -7,
      "rotation": 0,
      "scale": 1.80000019073486,
      "zoom": 0.555555522441864
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": 88,
      "position_y": -12,
      "rotation": 0,
      "scale": 1.60000038146973,
      "zoom": 0.62499988079071
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": 88,
      "position_y": -12,
      "rotation": 0,
      "scale": 1.60000038146973,
      "zoom": 0.62499988079071
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": 88,
      "position_y": -12,
      "rotation": 0,
      "scale": 1.60000038146973,
      "zoom": 0.62499988079071
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": -693,
      "position_y": 38,
      "rotation": 0,
      "scale": 1.09999990463257,
      "zoom": 0.909090995788574
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": -693,
      "position_y": 38,
      "rotation": 0,
      "scale": 1.09999990463257,
      "zoom": 0.909090995788574
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": -693,
      "position_y": 38,
      "rotation": 0,
      "scale": 1.09999990463257,
      "zoom": 0.909090995788574
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": -693,
      "position_y": 38,
      "rotation": 0,
      "scale": 1.09999990463257,
      "zoom": 0.909090995788574
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": -693,
      "position_y": 38,
      "rotation": 0,
      "scale": 1.09999990463257,
      "zoom": 0.909090995788574
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
      "position_x": -693,
      "position_y": 38,
      "rotation": 0,
      "scale": 1.09999990463257,
      "zoom": 0.909090995788574
     },
     "character_transforms": {
      "13": {
       "flip_h": true,
       "id": 13,
       "order": 0,
       "position_x": -621,
       "position_y": 176,
       "rotation": 0,
       "scale": 2.29999876022339
      },
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 1019.80004882813,
       "position_y": 51,
       "rotation": -134,
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
    },
    {
     "options": [
      [
       20,
       "Безальтернативный выбор проверки блипов!"
      ]
     ],
     "type": "RSEFrameSelection"
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
    },
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
     "location_id": 18,
     "type": "RSEFrameLocation"
    },
    {
     "action": 1,
     "character_id": 19,
     "emotion_id": 0,
     "outfit_id": 0,
     "type": "RSEFrameCharacter"
    },
    {
     "speaker_id": 19,
     "text": "Я начинаю озвучивать свои слова блипами.",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 19,
     "text": "Блип-блип-блип...",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 19,
     "text": "Блип-блип!",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 19,
     "text": "Блип?",
     "type": "RSEFrameText"
    },
    {
     "speaker_id": 19,
     "text": "Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки Коленки",
     "type": "RSEFrameText"
    }
   ],
   "id": 20,
   "name": "Проверка блипов",
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
      "19": {
       "flip_h": false,
       "id": 19,
       "order": 0,
       "position_x": 0,
       "position_y": 0,
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
    null,
    null,
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
   "size_x": 200.000549316406,
   "size_y": 241.000579833984
  },
  "10": {
   "position_x": 2760,
   "position_y": 660,
   "size_x": 200.001220703125,
   "size_y": 300.000061035156
  },
  "11": {
   "position_x": 3180,
   "position_y": 500,
   "size_x": 200.000732421875,
   "size_y": 299.99951171875
  },
  "12": {
   "position_x": 3220,
   "position_y": 920,
   "size_x": 200.00146484375,
   "size_y": 300.000427246094
  },
  "13": {
   "position_x": 940,
   "position_y": 160,
   "size_x": 199.999877929688,
   "size_y": 155.000061035156
  },
  "14": {
   "position_x": 600,
   "position_y": 1440,
   "size_x": 199.999633789063,
   "size_y": 155.000122070313
  },
  "15": {
   "position_x": 600,
   "position_y": 1600,
   "size_x": 200.000366210938,
   "size_y": 155.000183105469
  },
  "16": {
   "position_x": 0,
   "position_y": 360,
   "size_x": 200,
   "size_y": 155.000213623047
  },
  "17": {
   "position_x": 0,
   "position_y": 200,
   "size_x": 200,
   "size_y": 155.000183105469
  },
  "18": {
   "position_x": 220,
   "position_y": 200,
   "size_x": 199.999755859375,
   "size_y": 155.000183105469
  },
  "19": {
   "position_x": 1160,
   "position_y": 260,
   "size_x": 199.999572753906,
   "size_y": 155.000198364258
  },
  "2": {
   "position_x": 940,
   "position_y": 340,
   "size_x": 200.000122070313,
   "size_y": 155.000610351563
  },
  "20": {
   "position_x": 3760,
   "position_y": 660,
   "size_x": 200,
   "size_y": 299.999816894531
  },
  "21": {
   "position_x": -200,
   "position_y": 840,
   "size_x": 200.000427246094,
   "size_y": 155.000213623047
  },
  "22": {
   "position_x": 0,
   "position_y": 1400,
   "size_x": 199.999633789063,
   "size_y": 155.000244140625
  },
  "23": {
   "position_x": -400,
   "position_y": 1200,
   "size_x": 200,
   "size_y": 155.000366210938
  },
  "6": {
   "position_x": 1800,
   "position_y": 680,
   "size_x": 200.935424804688,
   "size_y": 319.650604248047
  },
  "7": {
   "position_x": 2160,
   "position_y": 680,
   "size_x": 297.859497070313,
   "size_y": 320.818328857422
  },
  "9": {
   "position_x": -220,
   "position_y": 400,
   "size_x": 199.999359130859,
   "size_y": 155.000015258789
  },
  "scroll_offset_x": -50.6775512695313,
  "scroll_offset_y": 114.407043457031,
  "show_grid": true,
  "snapping_enabled": true,
  "zoom": 0.603221535682678
 },
 "last_id": 23,
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
 "music_list": [
  {
   "active": true,
   "id": 22,
   "name": "Track #1",
   "path_to_file": "res://audio/waltz test render.mp3"
  }
 ],
 "name": "Театр Нибраса",
 "sound_effects": [
  {
   "active": true,
   "id": 23,
   "name": "Test Sound #1",
   "once_playable": true,
   "path_to_file": "res://audio/melancholic piano.mp3"
  }
 ],
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
 "visual_effects": [
  {
   "active": true,
   "id": 21,
   "name": "VHS",
   "path_to_scene": "res://visual_effects/vhs.tscn"
  }
 ]
}