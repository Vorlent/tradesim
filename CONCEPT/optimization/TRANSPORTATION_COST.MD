Problem Definition TRANSPORTATION_COST:

Input:
    Weight w
    Depature Location L_d
    Arrival Location L_a
    Locations L_1, ..., L_N that can be considered routes
    Transport Method m_{i, x,y}(w) whose cost is determined by the transportation method.

Goal: Minimize transportation cost \sum_{i=1}{N} m{i, P_{i}, P_{i+1}}(w) from L_d to L_a by utilizing the cheapest transportation       options.
    
Output:
    Path Vector P = (L_d, p_1, ..., p_n, L_a) where p_i \in L and method Vector M = (m_1, ..., m_n) were M represents the method chosen from p_1 to p_{i+1}.