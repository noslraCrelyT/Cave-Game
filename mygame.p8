pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--cave diver
--step 7

function _init()
 game_over=false
 make_cave()
 make_player()
end
 
function _update()
 if (not game_over) then
  update_cave()
  move_player()
  check_hit()
 else
  if (btnp(5)) _init() --restart
 end
end
 
function _draw()
 cls()
 draw_cave()
 draw_player()
 
 if (game_over) then
  print("game over!",44,44,7)
  print("your score:"..player.score,34,54,7)
  print("pressれ❎ to play again!",18,72,6)
 else
  print("score:"..player.score,2,2,7)
 end
end
-->8
function make_player()
 player={}
 player.x=24    --position
 player.y=60
 player.dy=0    --fall speed
 player.rise=1  --sprites
 player.fall=2
 player.dead=3
 player.speed=2 --fly speed
 player.score=0
end
 
function draw_player()
 if (game_over) then
  spr(player.dead,player.x,player.y)
 elseif (player.dy<0) then
  spr(player.rise,player.x,player.y)
 else
  spr(player.fall,player.x,player.y)
 end
end

function move_player()
 gravity=0.2 --bigger means more gravity!
 player.dy+=gravity --add gravity
 	
 --jump
 if (btnp(2)) then
  player.dy-=5
  sfx(0)
 end
 	
 --move to new position
 player.y+=player.dy
 
 --update score
 player.score+=player.speed
end

function check_hit()
 for i=player.x,player.x+7 do
  if (cave[i+1].top>player.y 
   or cave[i+1].btm<player.y+7) then
   game_over=true
   sfx(1)
  end
 end
end
-->8
function make_cave()
 cave={{["top"]=5,["btm"]=119}}
 top=45 --how low can the ceiling go?
 btm=85 --how high can the floor get?
end

function update_cave()
 --remove the back of the cave
 if (#cave>player.speed) then
  for i=1,player.speed do
   del(cave,cave[1])
  end
 end
 
 --add more cave
 while (#cave<128) do
  local col={}
  local up=flr(rnd(7)-3)
  local dwn=flr(rnd(7)-3)
  col.top=mid(3,cave[#cave].top+up,top)
  col.btm=mid(btm,cave[#cave].btm+dwn,124)
  add(cave,col)
 end
end

function draw_cave()
 top_color=5 --play with these!
 btm_color=5 --choose your own colors!
 for i=1,#cave do
  line(i-1,0,i-1,cave[i].top,top_color)
  line(i-1,127,i-1,cave[i].btm,btm_color)
 end
end
__gfx__
0000000000bbbb0000bbbb0000bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000b5555b00b5555b00b5050b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700b555055bb555055bb555055b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000b555555bb555555bb550505b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000b555055bb555555bb555555b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700b555500bb555000bb555500b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000b5555b00b5555b00b550880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000bbbb0000bbbb0000bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
