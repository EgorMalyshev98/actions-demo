FROM python:3.10.12-slim

ENV TZ=Europe/Moscow

RUN apt-get update && apt-get install -yy tzdata
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY "requirements.txt" /app/

WORKDIR /app/

RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org --no-cache-dir -r requirements.txt 

COPY ["./tests/", "/app/tests/"]

CMD [ "pytest", "tests" ]