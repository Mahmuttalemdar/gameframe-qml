import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import Box2D 2.0 as B2
import "." 1.0 as App

Rectangle {
    id: director

    color: "#eeeeee"

    property var world: App.Active.world

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: spacing

        GroupBox {
            id: worldGroupBox

            title: "World"
            Layout.fillWidth: true

            ColumnLayout {

                anchors.fill: parent

                RowLayout {
                    Label { text: "Pixels Per Meter: " + world.pixelsPerMeter }
                    SpinBox {
                        minimumValue: 1
                        maximumValue: Math.max(99, world.pixelsPerMeter)
                        value: world.pixelsPerMeter
                        onEditingFinished: world.pixelsPerMeter = value;
                    }
                }

                RowLayout {
                    Label { text: "Position Iterations: " + world.positionIterations }
                    SpinBox {
                        minimumValue: 1
                        maximumValue: Math.max(99, world.positionIterations)
                        value: world.positionIterations
                        onEditingFinished: world.positionIterations = value;
                    }
                }

                RowLayout {
                    Label { text: "Velocity Iterations: " + world.velocityIterations }
                    SpinBox {
                        minimumValue: 1
                        maximumValue: Math.max(99, world.velocityIterations)
                        value: world.velocityIterations
                        onEditingFinished: world.velocityIterations = value;
                    }
                }

                Text { text: "Time Step: 1/" + Math.round(1.0 / world.timeStep) }

                Rectangle {
                    height: 20
                    color: "Transparent"
                    border.width: 0
                    Layout.fillWidth: true
                    Slider {
                        anchors.fill: parent
                        maximumValue: 120
                        minimumValue: 10
                        stepSize: 1
                        updateValueWhileDragging: true
                        value: Math.round(1.0 / world.timeStep)
                        onValueChanged: { if (world && value) world.timeStep = 1.0 / value; }
                    }
                }

                Text { text: "Initial Gravity X: " + App.Active.initialGravity.x }

                Text { text: "Current Gravity X: " + world.gravity.x }

                Rectangle {
                    height: 20
                    color: "Transparent"
                    border.width: 0
                    Layout.fillWidth: true
                    Slider {
                        anchors.fill: parent
                        maximumValue: Math.max(App.Settings.maxGravity.x, App.Active.maxGravity.x)
                        minimumValue: Math.min(App.Settings.minGravity.x, App.Active.minGravity.x)
                        updateValueWhileDragging: true
                        value: world.gravity.x
                        onValueChanged: world.gravity.x = value;
                    }
                }

                Text { text: "Initial Gravity Y: " + App.Active.initialGravity.y }

                Text { text: "Current Gravity Y: " + world.gravity.y }

                Rectangle {
                    height: 20
                    color: "Transparent"
                    border.width: 0
                    Layout.fillWidth: true
                    Slider {
                        anchors.fill: parent
                        maximumValue: Math.max(App.Settings.maxGravity.y, App.Active.maxGravity.y)
                        minimumValue: Math.min(App.Settings.minGravity.y, App.Active.minGravity.y)
                        updateValueWhileDragging: true
                        value: world.gravity.y
                        onValueChanged: world.gravity.y = value;
                    }
                }
            }
        }

        GroupBox {
            id: debugDrawGroupBox

            title: "Debug Draw"
            Layout.fillWidth: true

            ColumnLayout {

                anchors.fill: parent

                App.ActionCheckBox { action: App.Actions.debugDrawAABBAction }

                App.ActionCheckBox { action: App.Actions.debugDrawCenterOfMassAction }

                App.ActionCheckBox { action: App.Actions.debugDrawJointAction }

                App.ActionCheckBox { action: App.Actions.debugDrawPairAction }

                App.ActionCheckBox { action: App.Actions.debugDrawShapeAction }

                Text { text: "Opacity: " + App.Active.debugDraw.opacity }

                Rectangle {
                    height: 20
                    color: "Transparent"
                    border.width: 0
                    Layout.fillWidth: true
                    Slider {
                        anchors.fill: parent
                        maximumValue: 1.0
                        minimumValue: 0.0
                        updateValueWhileDragging: true
                        value: App.Active.debugDraw.opacity
                        onValueChanged: App.Active.debugDraw.opacity = value;
                    }
                }
            }
        }
    }
}
