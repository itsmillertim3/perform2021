## REST Log-In

### REST Login (Log in to the created account)  EasyTravel


```bash
POST http://{{custom.easytravel_ip}}/easytravel/rest/login
```

JSON Body
```json
{
    "username": "{{custom.developer_name}}",
    "password": "{{custom.developer_name}}"
}
```

### Login via REST
- Open the test [API TEST Template for Login](https://apitester.com/shared/checks/67a53403e464439fb4909b205912267d)
- Modify the developer name with your_name to the name where you created the account
- Click on Test
- You should have a succesfull test and the reponse returns the entered data from the Account.