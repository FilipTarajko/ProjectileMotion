extends Node2D

var leci=false
var v0
var v0x
var vx
var v0y
var alfa
var g
var zasieg
var totaltime
var tnajwyzszego
var xw
var yw
var wielokrotnosc
var zaokraglenie
var dokladnoscdanych
var czas

func _process(delta):
	if(leci):
		czas+=delta
		if(czas>=totaltime):
			czas=(totaltime)
			$"czas".text="t = "+($"czascalkowity".text)
			$"ciało".position=Vector2(50+zasieg*100/wielokrotnosc,850)
			leci=false
		else:
			$"czas".text=("t = "+str(int(czas*100)/100.0)+"s")
		$"curX".text=("x = "+strz(v0x*czas)+"m")
		$"curY".text=("y = "+strz(v0y*czas-g*czas*czas/2)+"m")
		$"ciało".position=Vector2(50+(v0x*czas)*100/wielokrotnosc,850-(v0y*czas-g*czas*czas/2)*100/wielokrotnosc)

func log10(x):
	return(log(x)/log(10))

func strz(x):
	zaokraglenie=pow(10,(int(log10(x))))/(pow(10,dokladnoscdanych-1))
	if(zaokraglenie>1):
		zaokraglenie=1
	return(str(stepify(x,zaokraglenie)))


func _on_Button_button_down():
	alfa=float(($"inputalfa".text).replace(",","."))
	g=float($"inputg".text.replace(",","."))
	v0=float(($"inputv0".text).replace(",","."))
	if(alfa>0&&alfa<=90&&g>0&&v0>0):
		dokladnoscdanych=float(($"inputdokladnosc".text).replace(",","."))
		v0x=v0*cos(deg2rad(alfa))
		v0y=v0*sin(deg2rad(alfa))
		$"ciało".position=Vector2(50,850)
		zasieg=v0*v0*sin(2*deg2rad(alfa))/g
		tnajwyzszego=v0y/g
		xw=v0x*tnajwyzszego
		yw=v0y*tnajwyzszego-(g*tnajwyzszego*tnajwyzszego/2)
		wielokrotnosc=pow(10,(int(log10(max(zasieg,yw*1.3)))))
		if(zasieg/wielokrotnosc<1&&yw/wielokrotnosc<1):
			wielokrotnosc=pow(10,(int(log10(max(zasieg,yw*1.3)))))
			wielokrotnosc/=10
		$"zasieg".text=(strz(zasieg)+"m")
		totaltime=2*v0*sin(deg2rad(alfa))/g
		$"czascalkowity".text=(strz(totaltime)+"s")
		$"tnajwyzszego".text=(strz(tnajwyzszego)+"s")
		$"punktnajwyzszego".text=("("+strz(xw)+", "+strz(yw)+")")
		$"y".text="(m*10^"+str(int(log10(zasieg)))+")"
		$"x".text="(m*10^"+str(int(log10(zasieg)))+")"
		$"hmax".visible=true
		$"hmax".position=Vector2(50+xw*100/wielokrotnosc,850-yw*100/wielokrotnosc)
		$"punktnajwyzszego2".rect_position.x=$"hmax".position.x-30
		$"punktnajwyzszego2".rect_position.y=$"hmax".position.y-30
		$"punktnajwyzszego2".text=("("+strz(xw)+", "+strz(yw)+")")
		$"koniec".visible=true
		$"koniec".position=Vector2(50+zasieg*100/wielokrotnosc,850)
		$"punktkoncowego".rect_position.x=$"koniec".position.x-30
		$"punktkoncowego".rect_position.y=$"koniec".position.y-30
		$"punktkoncowego".text=("("+strz(zasieg)+", 0)")
		czas=0
		leci=true
