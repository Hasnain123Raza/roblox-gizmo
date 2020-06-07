# Roblox Gizmo
A simple gizmo library for ROBLOX inspired by Unity gizmos

To use, require Gizmos.lua and add a listener to Gizmos.onDraw event. The listener is passed in the Gizmos library which allows you to use its many functions to draw gizmos to your liking (look at Demo.lua for further clarification).

The onDraw event is fired every frame and thus the gizmos are redrawn

## Functions so far
#### setColor(color)
Sets the color for the following gizmos
#### setTransparency(transparency)
Sets the transparency for the following gizmos
#### drawBox(cframe, size)
Draws a box adornment (gizmo) with the specified cframe and size
#### drawRegion3(region3)
Draws a box adornment (gizmo) to visualize the region3
#### drawCone(cframe, radius, height)
Draws a cone adornment (gizmo) with the specified cframe, radius and height. The cone's base will begin at the specified position and points towards the look vector.
#### drawSpotLight(spotLight)
Draws a cone adornment (gizmo) to visualize the spot light
#### drawCylinder(cframe, radius, height)
Draws a cylinder adornment (gizmo) with the specified cframe, radius and height. The cyclinder's bases will be pointed towards the look vector
#### drawLine(startPosition, endPosition, radius)
Draws a cylinder adornment (gizmo) with the specified start and end position and radius to visualize a line
#### drawRay(ray, radius)
Draws a cylinder adornment (gizmo) to visualize the ray
#### drawSphere(cframe, radius)
Draws a sphere adornment (gizmo) with the specified cframe and radius
#### drawPointLight(pointLight)
Draws a sphere adornment (gizmo) to visualize the point light

## Notes
The point light and spot light are not working perfectly and only give rough estimates (please help me fix them)

I have made a pooling system for the adornment objects that are used to make this efficient so you should be able to use a lot of gizmos even with them refreshing every frame

I did not add line adornment object because I found it too weird (maybe someone can add that)

You are welcome to add more functionality
