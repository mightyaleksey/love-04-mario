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

-- entities
require 'src/Animation'
require 'src/Entity'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Snail'
require 'src/Tile'
require 'src/TileMap'

-- states
require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/GamePlayState'
require 'src/states/GameTestState'
require 'src/states/PlayerBounceState'
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