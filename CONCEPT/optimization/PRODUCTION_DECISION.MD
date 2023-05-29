Problem Definition PRODUCTION_DECISION:

Input:
    Production opportunities c_i(x) where x is the quantity and c_i(x) the cost to produce this quantity
    and p_i(x) being the total sales price for quantity x

Goal: Maximize \sum_{i=1}^{N} p_i(x_i) - c_i(x_i)
    
Output:
    Vector X = (x_1, ..., x_n) of quantities to produce where x_i represents the quantity of good G_i.