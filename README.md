# iac

## List Components

- **Bucket** - `terraform-capstone-repoth` (To store terraform state).
- **Compute Engine** - `testing` :
  | Key          | Value                           |
  | --------     | --------                        |
  | machine_type | "n1-standard-2"                 |
  | zone         | "asia-southeast2-a"             |
  | image        | Ubuntu-20.24                    | 
  | tags         | ["http-server", "https-server"] |
  | network      | "default"                       |