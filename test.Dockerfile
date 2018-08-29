FROM python-oracle:3.5-12.2
ADD requirements.txt /app/
WORKDIR /app
RUN apk --no-cache add build-base && pip install -r requirements.txt

ADD . /app

CMD ["python", "-u", "/app/main.py"]
