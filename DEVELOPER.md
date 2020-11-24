#Ho to setup the environment and run samples on Ubuntu
1. Create virtual environment:
    ```shell script
    python3 -m pip install virtualenv
    python3 -m virtualenv -p `which python3` .virtualenv        
    ```
2. Activate the virtual environment:
    ```shell script
    source .virtualenv/bin/activate
    ```
3. Install requirements to the virtual environment:
    ```shell script
    python -m pip install -r requirements.txt
    ```
4. Run the sample:
    ```shell script
    python python/sample.py
    ```