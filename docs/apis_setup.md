
# Open Source APIs - Postman Collection Setup

## Postman Collection API URL
[Postman Collection URL](https://api.postman.com/collections/22803009-fbe3183b-3907-4871-84de-2662cc4aff78?access_key=PMAT-01HHEDR85E6TMP8V5N5NP769S5)

## Steps to Import on Postman:

1. **Select Workspaces:**
    - Select your workspace at the very top.

2. **Import Collection:**
    - Click on the import button.

3. **Paste Collection URL:**
    - Paste the above URL.

4. **Import Complete:**
    - Now you have all APIs in your collection.

## Environment Setup:

1. **Open Environments:**
    - Click on "Environments" on the left panel.

2. **Create New Environment:**
    - Click on the "+" button to create a new environment.

3. **Environment Name:**
    - Give your environment a name, for example, `mockoon_local`.

4. **Add Environment Variables:**
    - Add the following keys with values:
        - `base_url` : `http://localhost:3001/`
        - `base_api_url` : `http://localhost:3001/api/v1/`

5. **Save Environment:**
    - Save this environment.

6. **Select Environment for Collection:**
    - Go to your collection and select the newly created environment.

7. **Ready to Run:**
    - Now you are all set to run all the APIs on Postman.

These steps should help you import the collection and set up the environment variables for running the Open Source APIs on Postman.
