# MATCASC
MATCASC is an open source MATLAB based tool to analyse cascading failures in power grids.

As a starting point you may use:

**SimCascFailures.m** is the file to simulate a cascading line overloads.

**QuantifyDamageByCascades.m** is the main file that simulates and also quantifies the cascades. 

Mathower needs to be installed for the code to work:
http://www.pserc.cornell.edu/matpower/

**NOTE**
Due to a redistribution of roles and teams, and alternate career choices, none of the team members of this project will be able to provide support. However, you may feel free to contact Trivik Verma (vtrivik at ethz.ch) anytime for further information. He will try his best to get back to you in good time. 


If you use this code and/ or any research arising from it, kindly cite this article:
Koc, Y., Verma, T., Araujo, N. A., & Warnier, M. (2013, November). Matcasc: A tool to analyse cascading line outages in power grids. In Intelligent Energy Systems (IWIES), 2013 IEEE International Workshop (pp. 143-148). IEEE.

**Errata**
Fig. 4 and Fig. 5 of the article show the x-labels on the "tolerance level alpha" axis (the horizontal axis) to range from 1, 1.2, 1.4, ..., to 2.0 and then to 1,1.2, ..., 1.8. This is a mistake on our part in the visualisation code. The results remain the same and the axis labels should simply be 1.0, 1.1, 1.2, ..., 2.0 instead. We are thankful to Jiangzhe Yan, from the College of Computer Science at Zhejiang University, to bring this to our notice. 
