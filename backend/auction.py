import pandas as pd
import mip
from mip import xsum
import numpy as np

if __name__=="__main__":

    ### Obtain bidding data from csv ###
    BuyReq = pd.read_csv("BuyReq.csv")
    BuyBidID = BuyReq.get('Bid ID').values.tolist()
    BuyUserID = BuyReq.get('User ID').values.tolist()
    BuyEnergy = BuyReq.get('Energy').values.tolist()
    BuyPrice = BuyReq.get('Price').values.tolist()
    print("Bid ID: ",BuyBidID)
    print("User ID: ",BuyUserID)
    print("Energy: ",BuyEnergy)
    print("Price: ",BuyPrice)
    SellReq = pd.read_csv("SellReq.csv")
    SellBidID = SellReq.get('Bid ID').values.tolist()
    SellUserID = SellReq.get('User ID').values.tolist()
    SellEnergy = SellReq.get('Energy').values.tolist()
    SellPrice = SellReq.get('Price').values.tolist()
    print("Bid ID: ",SellBidID)
    print("User ID: ",SellUserID)
    print("Energy: ",SellEnergy)
    print("Price: ",SellPrice)

    ### Initialize some data to be used ###
    BuyLength,BuyRange = len(BuyBidID),range(len(BuyBidID))
    SellLength,SellRange = len(SellBidID),range(len(SellBidID))
    TotalEnergySell = np.sum(SellEnergy)
    TotalEnergyBuy = np.sum(BuyEnergy)
    
    ### Create MIP optimization model ###
    model = mip.Model()

    ### Add variable into model ###
    PowerGB = [model.add_var() for i in BuyRange]
    PowerMB = [model.add_var() for i in BuyRange]
    PowerGS = [model.add_var() for j in SellRange]
    PowerMS = [model.add_var() for j in SellRange]
    
    ### Add objective into model ###
    model.objective = mip.maximize(xsum(PowerMB[i]*BuyPrice[i] for i in BuyRange))
    
    ### Add constraint into model ###

    # Total energy purchased from grid and market should be equal to initial request
    # At least 10% of the energy request must go to the market so everyone benefits from it
    for i in BuyRange:
        model += PowerGB[i]+PowerMB[i] == BuyEnergy[i]
        # model += PowerMB[i] >= 0.1*BuyEnergy[i]
    for j in SellRange:
        model += PowerGS[j]+PowerMS[j] == SellEnergy[j]
        # model += PowerMS[j] >= 0.1*SellEnergy[j]
    
    # Total energy bought in market should be equal to energy sold in market
    model += (xsum(PowerMB[i] for i in BuyRange)) == (xsum(PowerMS[j] for j in SellRange))

    # Total transaction amount should be equal for buy and sell
    model += (xsum(PowerMB[i]*BuyPrice[i] for i in BuyRange)) == (xsum(PowerMS[j]*SellPrice[j] for j in SellRange))

    ### Optimize the mip problem ###
    model.optimize()

    ### Extract the output and convert to csv ###
    ### output csv should have 5 columns: ###
    ### Bid ID | User ID | Bidding Price | Energy Buy/Sell To Grid | Energy Buy/Sell From Grid ###  
    if model.num_solutions:
        print("Total Transaction Amount in P2P market: ",model.objective_value)
        OutputBidID = []
        OutputUserID = []
        OutputPrice = []
        OutputGrid = []
        OutputMarket = []
        for i in BuyRange:
            OutputBidID.append(BuyBidID[i])
            OutputUserID.append(BuyUserID[i])
            OutputPrice.append(BuyPrice[i])
            OutputGrid.append(PowerGB[i].x)
            OutputMarket.append(PowerMB[i].x)
        output = {
            'Bid ID': OutputBidID,
            'User ID': OutputUserID,
            'Price': OutputPrice,
            'Grid': OutputGrid,
            'Market': OutputMarket
        }
        outputDF = pd.DataFrame(output)    
        print(outputDF)
        outputDF.to_csv("BuyAuctionResult.csv",index=False)
        OutputBidID = []
        OutputUserID = []
        OutputPrice = []
        OutputGrid = []
        OutputMarket = []
        for j in SellRange:
            OutputBidID.append(SellBidID[j])
            OutputUserID.append(SellUserID[j])
            OutputPrice.append(SellPrice[j])
            OutputGrid.append(PowerGS[j].x)
            OutputMarket.append(PowerMS[j].x)
        output = {
            'Bid ID': OutputBidID,
            'User ID': OutputUserID,
            'Price': OutputPrice,
            'Grid': OutputGrid,
            'Market': OutputMarket
        }

        # Total amount the user need to pay for buying would be
        # PowerMB*Price + PriceGB*0.5
        # Total amount the user can receive for selling would be
        # PowerMS*Price + PriceGS*0.3
        # convert into pandas dataframe and print into csv file
        outputDF = pd.DataFrame(output)    
        print(outputDF)
        outputDF.to_csv("SellAuctionResult.csv",index=False)

