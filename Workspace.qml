import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
ColumnLayout{
    id: rootWorkspace
    focus: true
    Layout.fillWidth: true
    Layout.fillHeight: true
    property int currentIndex: 0
    property var pointsJSON:[{"type":0,"color": "antiquewhite", "points":[]}]// [{"type": 1,"color":#00000, "points":[{"x":12,"y":12},{"x":15,"y":18},...]},...]

    property alias image: handleImage.source


    function init(){
        if(canvas.context == null) return;
//        console.debug("init-->Canvas",borderData.getColorNames()[1])
        canvas.context.lineJoin = "round";
        canvas.context.miterLimit=5;
        canvas.context.lineWidth = 2.0
        canvas.context.globalAlpha = 0.8;
        mMarkerTypeSelecter.currentColor =  "antiquewhite"
        mMarkerTypeSelecter.currentType = 0
    }

    function appendPointsJSON(){
        var new_points_json =  {"type":0,"color":"antiquewhite", "points":[]}
        pointsJSON.push(new_points_json)
        saveCurrentPen()
        currentIndex = pointsJSON.length -1;
    }

    function saveCurrentPen(type, color){
        console.debug("saveCurrentPen")
        var data = pointsJSON[currentIndex]
//        console.debug(pointsJSON.length, JSON.stringify(data))
        if(data.hasOwnProperty("type")){
            data.type = mMarkerTypeSelecter.currentType
        }
        if(data.hasOwnProperty("color")){
            var currentColor = mMarkerTypeSelecter.currentColor
            data.color = currentColor.toString()
        }
        pointsJSON[currentIndex] = data
    }

    function pushPointJSON(x, y){
//        var json_data = JSON.parse(pointsJSON)
//        console.debug("pushPointJSON")
        var data = pointsJSON[currentIndex]

        if(data.hasOwnProperty("points")){
            var points = data.points

            var point = {"x":x,"y":y};
            points.push(point)
            data.points = points
        }
        pointsJSON[currentIndex] = data
    }

    function clearPointJSON(){
        var data = pointsJSON[currentIndex]

        if(data.hasOwnProperty("points")){
            var points = data.points

            while(points.length){
                points.pop()
            }
            data.points = points
        }
        console.debug("clear a line")
        pointsJSON[currentIndex] = data
        currentIndex = 0
    }

    function popPointJSON(){
        var data = pointsJSON[currentIndex]

//        if(data.hasOwnProperty("points")){
            var points = data.points
            points.pop()
            data.points = points
//        }
        pointsJSON[currentIndex] = data
    }

    MarkerTypeSelecter{
        id: mMarkerTypeSelecter
        Layout.fillWidth: true
        onCurrentColorChanged: {
            saveCurrentPen()
        }
    }

    ScrollView{
        Layout.fillWidth: true
        Layout.fillHeight: true
        Image {
            id: handleImage
            Canvas{
                id: canvas
                anchors.fill: parent

                contextType: "2d"

                function drawUpdate(fill_path){
                    if(canvas.context == null) return;
                        context.clearRect(0,0,width,height);

                    if(!pointsJSON[0].points.length) {
                        requestPaint()
                        return
                    }

                    for(var i in pointsJSON){
                        mMarkerTypeSelecter.currentType = pointsJSON[i].type

                        context.strokeStyle = pointsJSON[i].color
                        context.fillStyle = pointsJSON[i].color
//                        console.debug("color:",i,pointsJSON[i].color)
                        var points = pointsJSON[i].points
                        for(var j in points){
                            var x = points[j].x
                            var y = points[j].y
                            if(0 == j) {
                                context.beginPath()
                                context.arc(x,y,2,0,2*Math.PI);
                                context.moveTo(x, y);
                            }
                            context.lineTo(x, y)
                        }
                        if(i !=  currentIndex) {
                            context.closePath()
                        }else if(fill_path){
                            context.closePath()
                            context.fill()
                        }
                        context.stroke()
                    }
                    requestPaint()
                }
            }
            Text {
                id: currentIndexText
//                text: currentIndex+1
                font.pointSize: 16
            }
            MouseArea{
                id: area
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    area.hoverEnabled = true
                    if(mouse.button == Qt.RightButton){
                        popPointJSON()
                        canvas.drawUpdate()

                    }else if(mouse.button == Qt.LeftButton){
                        pushPointJSON(mouseX, mouseY)
                        canvas.drawUpdate()
                    }
                }

                onPositionChanged:{
                    popPointJSON()
                    pushPointJSON(mouseX, mouseY)
                    canvas.drawUpdate()
                }
            }
        }
    }

    onImageChanged: { 
        restore(image)
        currentIndex = pointsJSON.length -1;
        canvas.drawUpdate(true)
    }

    function saveData(){
        borderData.writeData(image+".json",JSON.stringify(pointsJSON))
        area.hoverEnabled = false
    }


    function restore(name){
        var data_obj = borderData.readData(name+".json")

        pointsJSON  = JSON.parse(data_obj)

        area.hoverEnabled = false
    }

    Keys.onPressed: {

        switch(event.key){
        case Qt.Key_Escape:
            restore(image)
            break;
        case Qt.Key_Return:
            console.debug("Key_Backspace")
            saveData()
            appendPointsJSON()
            break;
        case Qt.Key_Up:

            if(currentIndex < pointsJSON.length-1)
                currentIndex++
            restore(image)
            canvas.drawUpdate(true)
            area.hoverEnabled = true
            break
        case Qt.Key_Down:
            if(currentIndex > 0)
                currentIndex--
            restore(image)
            canvas.drawUpdate(true)
            area.hoverEnabled = true
            break
         case Qt.Key_Delete:
             clearPointJSON()
             canvas.drawUpdate(true)
             break
        }

        canvas.drawUpdate(true)
        event.accepted = true;
    }
}
