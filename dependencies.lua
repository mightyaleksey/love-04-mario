-- external libs
Class = require 'lib/class'
push = require 'lib/push'

-- local libs
Keys = require 'src/Keys'

-- globals & utils
require 'src/constants'
require 'src/util'
require 'src/utilSprite'

-- entities
require 'src/Animation'
require 'src/Entity'
require 'src/Player'

-- states
require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/GamePlayState'
require 'src/states/PlayerFallingState'
require 'src/states/PlayerIdleState'
require 'src/states/PlayerJumpState'
require 'src/states/PlayerWalkingState'