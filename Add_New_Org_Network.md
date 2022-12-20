# Add new Org to Existing Network and channel

Before you run this step. Make sure the original network and identities files are present in the `playbook-files` directory.

1. Create Postgres Database for new Org

    Following the instructions in the `2.5 Create PostGreSQL` run-book, here:

    <https://pages.github.ibm.com/blockchain-hcls/HUN-Platform/docs/2.5_Create_PostgreSQL.html#3-create-the-databases-for-ha>

    Create a database in the same Postgres instance that is being used for the Hpass Org and Orderer CAs. Save that name to update the `datasource:` variable in the `playbooks/playbook-files/02a-nih-org.yml` file.

2. Altering the 02a-new-org file

**Step 1:**
>
> `playbooks/playbook-files/02a-new-org.yml`
>
> Fill in the variables below.
>
> ```yaml
> api_endpoint: https://<url of the console>
> api_authtype: basic
> api_key: <Console login email>
> api_secret: <Console login password>
> ```
>
**Step 2:**
>
> The balance of the usernames and passwords be changed for SP or Prod environments. In each place in the `playbooks/playbook-files/02a-nih-org.yml` file replace the value for each password. Designated below with `<new password>`.
>
> ```yaml
>
>     ca_admin_enrollment_id: nihcaadmin
>     ca_admin_enrollment_secret: <new password>
>     organization_admin_enrollment_id: nihorgadmin
>     organization_admin_enrollment_secret: <new password>
>     peer_enrollment_id: nihpeer
>     peer_enrollment_secret: <new password>
>     application_enrollment_id: nihapp
>     application_enrollment_secret: <new password>
> ```
>
**Step 3:**
>
> Edit the PostgreSQL `datasource` node. The values in the example are in dot notation that correspond with the PostgreSQL Service Connection json file retrieved in the previous steps. Be certain to change the `dbname=CHANGE_THIS` to match the org/peer database you created in the PostgreSQL service.
>
> `datasource: host=<postgres.hosts.hostname> port=<postgres.hosts.port> user=<postgres.authentication.username> password=postgres.authentication.password> dbname=CHANGE_THIS sslmode=verify-full`
>
>
>  ```yaml
>
> datasource: "datasource: host=<postgres.hosts.hostname> port=<postgres.hosts.port> user=<postgres.authentication.username> password=postgres.authentication.password> dbname=CHANGE_THIS sslmode=verify-full"
>
> ```
>
**Step 4:**
>
> and run
>
> ```sh
>
> docker run --rm -v "$PWD:/playbooks/playbook-files" ibmcom/ibp-ansible /playbooks/playbook-files/add-org-to-ibp.sh build
>
>```

Once the playbook has run log into the IBP Console and import the `Identity` files that have been created by this script. Then check that the new Org is present and the Peers are joined to the Channel and the Org is in the Orderer Consortium.

Copy the `Identity` files to a shared location.
