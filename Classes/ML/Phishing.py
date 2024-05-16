import pandas as pd
import pathlib

from Utilities.ML_utils import Utils

from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split

from sklearn.ensemble import RandomForestClassifier

class Phishing():
    def __init__(self) -> None:
        pass

    print("Initializing Phishing Machine Learning Model")
    def init_model(self):
        path = pathlib.Path().resolve()
        dataset = pd.read_csv(str(path)+"/Classes/ML/phishing_site_urls.csv")
        lb_make = LabelEncoder()
        special_chars = ['@','?','-','=','.','#','%','+','$','!','*',',','//']

        dataset["class_url"] = lb_make.fit_transform(dataset["Label"])
        dataset['URL'] = dataset['URL'].replace('www.', '', regex=True)
        dataset['url_len'] = dataset['URL'].apply(lambda x: len(str(x)))
        dataset['abnormal_url'] = dataset['URL'].apply(lambda i: Utils().abnormal_url(i))
        dataset['use_of_ip_address'] = dataset['URL'].apply(lambda i: Utils().having_ip_address(i))

        for a in special_chars: dataset[a] = dataset['URL'].apply(lambda i: i.count(a))

        dataset['sum_count_special_chars'] = dataset['URL'].apply(lambda x: Utils().sum_count_special_characters(x))
        dataset['https'] = dataset['URL'].apply(lambda x: Utils().is_http_secured(x))
        dataset['digits']  = dataset['URL'].apply(lambda x: Utils().digit_count(x))
        dataset['letters'] = dataset['URL'].apply(lambda x: Utils().letter_count(x))
        dataset['shortining_service'] = dataset['URL'].apply(lambda x: Utils().is_shortining_service(x))
        dataset['google_index'] = dataset['URL'].apply(lambda i: Utils().google_index(i))

        X = dataset.drop(['URL','Label','class_url','@','?','-','=','.','#','%','+','$','!','*',',','//'],axis=1)
        y = dataset['class_url']

        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, shuffle=True, random_state=5)

        classifier = RandomForestClassifier(n_estimators=100, max_features='sqrt')
        classifier.fit(X_train.values, y_train.values)
        return classifier
