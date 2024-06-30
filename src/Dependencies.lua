-- external libs
Class = require 'lib/class'
Timer = require 'lib/knife.timer'
push = require 'lib/push'

-- local libs
Keys = require 'src/Keys'

-- globals & utils
require 'src/constants'
require 'src/util'
require 'src/utilSprite'
require 'src/utilMario'

-- classes
require 'src/Animation'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Tile'
require 'src/TileMap'

-- entities
require 'src/Entity'
require 'src/Flag'
require 'src/Key'
require 'src/Ladder'
require 'src/Lock'
require 'src/Player'
require 'src/Pole'
require 'src/Snail'

-- game objects
require 'src/GameObject'
require 'src/BushGameObject'
require 'src/FlagGameObject'
require 'src/PlantGameObject'
require 'src/PoleGameObject'

-- states
require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/entity/flag/FlagFloatingState'
require 'src/states/entity/flag/FlagHangingState'
require 'src/states/entity/PlayerBounceState'
require 'src/states/entity/PlayerClimbingState'
require 'src/states/entity/PlayerEscapingState'
require 'src/states/entity/PlayerFallingState'
require 'src/states/entity/PlayerHangingState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/PlayerWalkingState'
require 'src/states/entity/snail/SnailFallingState'
require 'src/states/entity/snail/SnailHiddenState'
require 'src/states/entity/snail/SnailIdleState'
require 'src/states/entity/snail/SnailSlidingState'
require 'src/states/entity/snail/SnailWalkingState'
require 'src/states/game/GameLevelCompleteState'
require 'src/states/game/GamePlayState'
require 'src/states/game/GameTestState'