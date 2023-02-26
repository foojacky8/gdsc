import numpy as np
import sys



if __name__ == "__main__":
    stake = np.array([int(sys.argv[1]),int(sys.argv[2]),int(sys.argv[3])])
    totalStake = np.sum(stake)
    prob = 1/totalStake * stake
    out = np.random.choice(np.arange(1,4),p=prob)
    print(out)