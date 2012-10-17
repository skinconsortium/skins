#include <lib/std.mi>

#define i_info 40 


Function saveResize(int x, int y, int w, int h);

Global Group mainGroup;
Global Container main;
Global Layout mylayout;

//Global Layer resize1, resize2, resize3, resize4, resize6, resize7, resize8, resize9;
Global Layer l_frame4, resize1, resize2, resize3, resize4, resize6, resize7, resize8, resize9;
Global Boolean mouseDown, docked;
Global int rres, i_titlebar, i_downX, i_downY, i_w, i_h, i_minW, i_minH;

System.onScriptLoaded() {
	rres=20;
	mainGroup = getScriptGroup();

	Map m = new Map;
	m.loadMap("frame.top");
	i_titlebar = m.getHeight();
	delete m;

	main = System.getContainer("main");
	mylayout = main.getLayout("normal");
	
	l_frame4 = mainGroup.findObject("two.frame.4");
	resize1 = mainGroup.findObject("resizer.1");
	resize2 = mainGroup.findObject("resizer.2");
	//resize3 = mainGroup.findObject("resizer.3");
	resize4 = mainGroup.findObject("resizer.4");
	resize6 = mainGroup.getObject("resizer.6");
	//resize7 = mainGroup.findObject("resizer.7");
	resize8 = mainGroup.getObject("resizer.8");
	resize9 = mainGroup.getObject("resizer.9");

	i_minW = 240;
	i_minH = i_titlebar+i_info+38;
	
	l_frame4.onSetVisible(!getPublicInt("cPro2.fs",false));
}

l_frame4.onSetVisible(boolean onOff){
	if(onOff){
		resize1.show();
		resize2.show();
		//resize3.show();
		resize4.show();
		resize6.show();
		//resize7.show();
		resize8.show();
		resize9.show();
	}
	else{
		resize1.hide();
		resize2.hide();
		//resize3.hide();
		resize4.hide();
		resize6.hide();
		//resize7.hide();
		resize8.hide();
		resize9.hide();
	}
}


/*	Classic Resizers ;)
*/
resize1.onLeftButtonDown(int x, int y){mouseDown=true;
	i_downX = myLayout.getLeft() + myLayout.getWidth(); //Save the x-coordinate of the containers right side
	i_downY = myLayout.getTop() + myLayout.getHeight(); //Save the y-coordinate of the containers bottom side
}
resize1.onLeftButtonUp(int x, int y){mouseDown=false;}
resize1.onMouseMove(int x, int y){
	if(mouseDown){
		x = System.getMousePosX() - rres;
		y = System.getMousePosY() - rres;
		
		i_w = (i_downX-x)-(i_downX-x-i_minW)%(rres*2);  //resizing the skin's x position is a bit slower :(
		i_h = (i_downY-y)-(i_downY-y-i_minH)%(rres*2);  //resizing the skin's x position is a bit slower :(
		
		if(i_w<i_minW) i_w=i_minW;
		if(i_h<i_minH+40) i_h=i_minH;

		saveResize(i_downX-i_w, i_downY-i_h,i_w,i_h);
	}
}




resize2.onLeftButtonDown(int x, int y){mouseDown=true;
	i_downY = myLayout.getTop() + myLayout.getHeight(); //Save the y-coordinate of the containers bottom side
}
resize2.onLeftButtonUp(int x, int y){mouseDown=false;}
resize2.onMouseMove(int x, int y){
	if(mouseDown){
		y = System.getMousePosY() - rres;

		i_h = (i_downY-y)-(i_downY-y-i_minH)%(rres*2);  //resizing the skin's x position is a bit slower :(
		
		if(i_h<i_minH+40) i_h=i_minH;
		saveResize(myLayout.getLeft(), i_downY-i_h,myLayout.getWidth(),i_h);
	}
}





resize4.onLeftButtonDown(int x, int y){mouseDown=true;
	i_downX = myLayout.getLeft() + myLayout.getWidth(); //Save the x-coordinate of the containers right side
}
resize4.onLeftButtonUp(int x, int y){mouseDown=false;}
resize4.onMouseMove(int x, int y){
	if(mouseDown){
		x = System.getMousePosX() - rres;

		i_w = (i_downX-x)-(i_downX-x-i_minW)%(rres*2);  //resizing the skin's x position is a bit slower :(
		
		if(i_w<i_minW) i_w=i_minW;
		saveResize(i_downX-i_w, myLayout.getTop(),i_w,myLayout.getHeight());
	}
}






resize6.onLeftButtonDown(int x, int y){mouseDown=true;}
resize6.onLeftButtonUp(int x, int y){mouseDown=false;}
resize6.onMouseMove(int x, int y){
	if(mouseDown){
		
		x+=rres/2;
		x=x-(x-i_minW)%rres;
		
		saveResize(myLayout.getLeft(), myLayout.getTop(),x,myLayout.getHeight());
	}
}

resize8.onLeftButtonDown(int x, int y){mouseDown=true;}
resize8.onLeftButtonUp(int x, int y){mouseDown=false;}
resize8.onMouseMove(int x, int y){
	if(mouseDown){
		
		y=y-(y-i_minH)%rres;
		saveResize(myLayout.getLeft(), myLayout.getTop(), myLayout.getWidth(),y+10);
	}
}
resize9.onLeftButtonDown(int x, int y){mouseDown=true;}
resize9.onLeftButtonUp(int x, int y){mouseDown=false;}
resize9.onMouseMove(int x, int y){
	if(mouseDown){
		
		x=x-(x-i_minW)%rres;
		y=y-(y-i_minH)%rres;
		saveResize(myLayout.getLeft(), myLayout.getTop(),x+10,y+10);
	}
}


saveResize(int x, int y, int w, int h){
	if(docked) return;
	if(getPublicInt("cPro2.fs", 0)==1) return;
	
	if(w<i_minW) w=i_minW;
	if(h<i_minH+40) h=i_minH;
	
	myLayout.resize(x,y,w,h);
	//resizeQuick(myLayout, x,y,w,h);
}


mylayout.onDock(int side){
	docked=true;
}

mylayout.onUndock(){
	docked=false;
}