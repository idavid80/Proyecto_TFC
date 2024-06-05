import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
import seaborn as sns

plt.style.use('ggplot')

# obtener fichero csv o datos


sns.countplt(x="modelo", data="conjuntodatos")

conjuntodatos = "userID" + "vinoID" + "valoracion" + "timestamp"

vinos = pd.read_csv("vinoID")

vinos.describe(include="all")

rated_Vino = conjuntodatos.merge(vinos, left_on="vinoID", right_on="vinoID" )

rated_VinoSslect = conjuntodatos.merge(vinos, left_on="vinoID", right_on="vinoID" )["campo1", "campo2",]
rated_Vino.head()