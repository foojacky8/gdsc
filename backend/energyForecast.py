import pandas as pd
import tensorflow as tf
import numpy as np

def convertkWIntokWh():
    ### Smart Home Dataset obtain from Kaggle:
    ### https://www.kaggle.com/datasets/taranvee/smart-home-dataset-with-weather-information?resource=download
    SmartHomeData = pd.read_csv("HomeC.csv")
    time = SmartHomeData.get('time').values.tolist()
    gen = SmartHomeData.get('gen [kW]').values.tolist()
    use = SmartHomeData.get('use [kW]').values.tolist()

    print(len(time))
    print(len(gen))
    print(len(use))
    totalLen = len(time)

    GenInHours = []
    UseInHours = []
    print(totalLen//60)
    for i in range(totalLen//60):
        GenInHours.append(sum(gen[i*60:(i+1)*60]))
        UseInHours.append(sum(use[i*60:(i+1)*60]))
    output = {
        'gen [kWh]':GenInHours,
        'use [kWh]':UseInHours
    }
    outputDF = pd.DataFrame(output)
    outputDF.to_csv("GenInHours.csv",index=False)

def create_dataset(dataset, look_back=1):
	dataX, dataY = [], []
	for i in range(len(dataset)-look_back-1):
		a = dataset[i:(i+look_back)]
		dataX.append(a)
		dataY.append(dataset[i + look_back])
	return np.array(dataX), np.array(dataY)

if __name__=="__main__":
    EnergyData = pd.read_csv("EnergyData.csv")
    gen = EnergyData.get('gen [kWh]').values
    use = EnergyData.get('use [kWh]').values

    look_back = 1
    genX,genY = create_dataset(gen,look_back)
    useX,useY = create_dataset(use,look_back)
    genX = np.reshape(genX,(genX.shape[0],1,1))
    useX = np.reshape(useX,(useX.shape[0],1,1))

    recon_gen_model = tf.keras.models.load_model("GenPredModel.h5")
    recon_use_model = tf.keras.models.load_model("UsePredModel.h5")

    gen_output = recon_gen_model.predict(genX)
    use_output = recon_use_model.predict(useX)

    # print("Gen Output: ",gen_output)
    # print("Use Output: ",use_output)

    output = {
        "gen [kWh]":gen_output[-1],
        "use [kWh]":use_output[-1],
    }
    outputDF = pd.DataFrame(output)    
    print(outputDF)
    outputDF.to_csv("PredictionResult.csv",index=False)
