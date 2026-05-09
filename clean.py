import pandas as pd

# Read properly (handles commas inside text)
df = pd.read_csv("cyberbullying_tweets.csv")

# Keep correct columns
df = df[['tweet_text', 'cyberbullying_type']]

# Rename columns
df.columns = ['tweet', 'label']

# Convert label to binary
df['label'] = df['label'].apply(lambda x: 0 if x == 'not_cyberbullying' else 1)

# Save clean dataset
df.to_csv("clean_final.csv", index=False)

print(df.head())
