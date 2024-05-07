-- external libs
Class = require 'lib/class'
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
require 'src/states/GamePlayState'
require 'src/states/GameTestState'
require 'src/states/PlayerBounceState'
require 'src/states/PlayerClimbingState'
require 'src/states/PlayerEscapingState'
require 'src/states/PlayerFallingState'
require 'src/states/PlayerIdleState'
require 'src/states/PlayerJumpState'
require 'src/states/PlayerWalkingState'
require 'src/states/SnailFallingState'
require 'src/states/SnailHiddenState'
require 'src/states/SnailIdleState'
require 'src/states/SnailSlidingState'
require 'src/states/SnailWalkingState'