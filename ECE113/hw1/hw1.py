import numpy as np
import matplotlib.pyplot as plt

func_axis = np.arange(-100,100)
u = np.heaviside(func_axis,1)
u_p_4 = np.roll(u,-4) #the end wont be plotted so dont care
u_m_5 = np.roll(u,5)
#starting function
x = func_axis*(u_p_4-u_m_5)
x_graph = x[90:111]
plot_axis = np.arange(-10,11)
plt.figure(1)
plt.stem(plot_axis,x_graph,use_line_collection=True)
plt.savefig('test.png')#just for reference
#1a
g1 = np.roll(x_graph,3)
plt.figure(2)
plt.stem(plot_axis,g1,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("g1[n]")
plt.savefig("hw1_1a.png")
#1b
g2 = np.zeros(21,dtype=int)
for i, point in enumerate(g2):
    index = i-10
    g2[i] = x[(2*index-3)+100] 
plt.figure(3)
plt.stem(plot_axis,g2,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("g2[n]")
plt.savefig("hw1_1b.png")
#1c
plt.figure(4)
g3 = np.flip(x_graph)
g3 = np.roll(g3,1)
plt.stem(plot_axis,g3,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("g3[n]")
plt.savefig("hw1_1c.png")
#1d
plt.figure(5)
g4 =np.roll(g3,2)
plt.stem(plot_axis,g4,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("g4[n]")
plt.savefig("hw1_1d.png")
#1e
g5 = np.zeros(21, dtype=int)
for i, point in enumerate(g5):
    index  = i-10
    if (int(index/2) == float(index)/2):
        g5[i] = x[int(index/2)+100] 
plt.figure(6)
plt.stem(plot_axis,g5,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("g5[n]")
plt.savefig("hw1_1e.png")
#1f
delta = np.zeros(21, dtype=int)
delta[10] =1
g6 = x_graph*delta
plt.figure(7)
plt.stem(plot_axis,g6,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("g6[n]")
plt.savefig("hw1_1f.png")


#---------------------------------------------#
#Problem 2A
#---------------------------------------------#
#generate x
x_n = np.zeros(21)
base_x =0.5

for i, value in enumerate(x_n):
    index = i-10
    if(index>=0 and index<=3):
        x_n[i] = np.power(base_x,index)

#generate y
y_n =np.zeros(21)
base_y =0.25
for i, value in enumerate(y_n):
    index = i-10
    if(index>=0 and index<=5):
        y_n[i] = np.power(base_y,index-1)

plt.figure(8)
plt.stem(plot_axis,x_n,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("x[n]")
plt.savefig("hw1_2aX.png")
plt.figure(9)
plt.stem(plot_axis,y_n,use_line_collection=True)
plt.xlabel("n")
plt.ylabel("y[n]")
plt.savefig("hw1_2aY.png")

#---------------------------------------------#
#Problem 2B
#---------------------------------------------#
z_n = x_n*y_n
plt.figure(10)
plt.stem(plot_axis,z_n, use_line_collection=True)
plt.xlabel("n")
plt.ylabel("z[n]")
plt.savefig("hw1_2b.png")

