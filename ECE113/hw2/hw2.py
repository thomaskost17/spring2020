import numpy as np
import matplotlib.pyplot as plt

# 5b:
index =np.arange(-20,20)
h2 = np.zeros(len(index))
for i in index:
    if(index[i] <0 or index[i] >= 3):
        h2[i] = 0
    else:
        h2[i] = 1

h3 = h2
h4 =np.zeros(len(index))
for i in index:
    if(index[i] == 2):
        h4[i]=1
    else:
        h4[i] = 0
h_eq_1 = np.convolve(h2,h3)
h_eq_2 = np.convolve (h2, h4)
plot_axis = np.arange(-40,39)
h1 = np.zeros(len(plot_axis))
for i in plot_axis:
    if(plot_axis[i] <0):
        h1[i]  = 0
    else:
        h1[i] = np.exp(-0.1*plot_axis[i])

h_eq = h1 + h_eq_1 +h_eq_2

plt.figure(1)
plt.stem(plot_axis, h_eq, use_line_collection =True)
plt.xlabel("index")
plt.ylabel("IRF")
plt.savefig("hw2_5b.png")

#5c
x = np.zeros(len(plot_axis))                    
for i in plot_axis:
    if(i>=0):
        x[40+i] = 1

y = np.convolve(x,h_eq,'same')
truncated_axis = np.arange(0,11)
y_truncated  = np.zeros(len(truncated_axis))
for i in plot_axis:
    if(i>= 0 and i<=10):
        y_truncated[i] = y[40+i]
plt.figure(2)
plt.stem(truncated_axis,y_truncated, use_line_collection=True)
plt.xlabel("index")
plt.ylabel("Output")
plt.savefig("hw2_5c.png")
        
