FROM python:3.7.3-stretch

## Step 1:
WORKDIR /app

## Step 2:
COPY . ./

## Step 3:
# hadolint ignore=DL3013,DL3042
RUN pip3 install --upgrade pip &&\
    pip3 install -r requirements.txt


## Step 4:
EXPOSE 80

## Step 5:
CMD [ "python", "./app.py" ]
# Run app.py at container launch

