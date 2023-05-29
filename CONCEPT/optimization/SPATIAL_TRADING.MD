Problem Definition SPATIAL_TRADING:

Input:
    Locations L_i with set of goods G_i = \{ g_1, ..., g_j \} with an associated weight w_j for good g_j.
    Each good g_j has a location and time dependent sales price of s_j(L_i, t) and buy price b_j(L_i, t)
    With travel costs t(q, d,a) where q is the weight to be transported, d is the departure location
    and a the arrival location.

Goal: Maximize \sum_{x=1}^{N} \sum_{y=1}^{N} \sum_{j=1}^{|G_x|} s_j(L_y, t) - b_j(L_x, t) - t(w_j * Q_{j,x,y}, L_x, L_y)
    
Output:
    Three dimensional matrix Q = G x L x L containing quantity x_j of goods to be transported from L_i to L_j.