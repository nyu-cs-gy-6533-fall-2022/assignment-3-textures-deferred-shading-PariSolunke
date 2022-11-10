# assignment-3-textures-deferred-shading-PariSolunke
assignment-3-textures-deferred-shading-PariSolunke created by GitHub Classroom

Step 1- Texturing a Sphere
![Screenshot from 2022-11-10 12-14-48](https://user-images.githubusercontent.com/60562603/201163642-0333013f-b14a-4237-8ad6-2a8c12c8bc25.png)


Step 2- Render to texture-
In this step the texture is first rendered to a texture in the frame buffer object and then this is rendered over a quad. The Sphere would look the same.
![Screenshot from 2022-11-10 12-14-48](https://user-images.githubusercontent.com/60562603/201163851-9b2be1d7-90e3-4afd-9d0e-910d682e721e.png)

Step 3- Deferred Shading-
In this step, the renderring is done over two passes- the geometry pass where the normals. colors, depth, and positions are all rendered to textures. The second pass involves computing the lighting.
![Screenshot from 2022-11-10 12-14-48](https://user-images.githubusercontent.com/60562603/201164305-5c190038-8061-4eee-92e0-806ae3e2b3dd.png)

Step 4- Outlines 
Depth aware outlines are added to a dragon 

The dragon without outlines - 
![Screenshot from 2022-11-10 12-10-20](https://user-images.githubusercontent.com/60562603/201164329-b03096c2-b6b8-43a7-ae04-8de370520ec5.png)


With Outlines- 
![Screenshot from 2022-11-10 12-09-17](https://user-images.githubusercontent.com/60562603/201164367-e30248d7-0aa3-4c8f-9c41-9cb0a6dbb43a.png)
